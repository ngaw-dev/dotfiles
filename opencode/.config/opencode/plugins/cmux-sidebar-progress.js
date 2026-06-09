// cmux-sidebar-progress-plugin-marker v1
// Translates OpenCode task lifecycle events into cmux sidebar indicators
// (status pills, progress bar, log entries).
// Companion to cmux-feed.js and cmux-session.js — not a replacement.

import { spawnSync } from "node:child_process";

const CMUX_SIDEBAR_PLUGIN_KEY = Symbol.for("cmux.sidebar.progress.plugin.installed");

function cmux(...args) {
  try {
    spawnSync("cmux", args, {
      timeout: 5000,
      stdio: ["ignore", "ignore", "ignore"],
      env: { ...process.env },
    });
  } catch (_) {}
}

function cmuxLog(level, source, message) {
  try {
    spawnSync("cmux", ["log", "--level", level, "--source", source, "--", message], {
      timeout: 5000,
      stdio: ["ignore", "ignore", "ignore"],
      env: { ...process.env },
    });
  } catch (_) {}
}

function todosInfo(todos) {
  if (!Array.isArray(todos) || todos.length === 0) return null;
  const total = todos.length;
  const completed = todos.filter((t) => t.status === "completed").length;
  const inProgress = todos.find((t) => t.status === "in_progress");
  const fraction = total > 0 ? completed / total : 0;
  return { total, completed, inProgress, progress: fraction };
}

function truncate(text, max) {
  if (typeof text !== "string") return "";
  return text.length > max ? text.slice(0, max - 1) + "\u2026" : text;
}

const CMUXSidebarProgress = async (ctx) => {
  if (globalThis[CMUX_SIDEBAR_PLUGIN_KEY]) return {};
  globalThis[CMUX_SIDEBAR_PLUGIN_KEY] = true;

  return {
    event: async ({ event }) => {
      const props = (event && event.properties) || {};

      switch (event && event.type) {
        case "session.created":
          cmux("set-status", "opencode", "Running", "--color", "#007aff", "--icon", "hammer");
          cmux("set-progress", "0", "--label", "Session started");
          cmuxLog("info", "opencode", "Session started");
          break;

        case "todo.updated": {
          const info = todosInfo(props.todos);
          if (!info) break;

          if (info.inProgress) {
            cmux(
              "set-status",
              "opencode",
              truncate(info.inProgress.content, 50),
              "--color",
              info.inProgress.priority === "high" ? "#ff3b30" : "#ff9500",
              "--icon",
              "hammer"
            );
          }

          if (info.progress > 0 && info.progress < 1) {
            cmux(
              "set-progress",
              String(info.progress),
              "--label",
              `${info.completed}/${info.total} \u2014 ${truncate(info.inProgress ? info.inProgress.content : "working", 30)}`
            );
          } else if (info.progress >= 1) {
            cmux("set-progress", "1", "--label", `${info.total}/${info.total} tasks complete`);
            cmux("set-status", "opencode", "All tasks complete", "--color", "#34c759", "--icon", "checkmark");
            cmuxLog("success", "opencode", `All ${info.total} tasks completed`);
          } else {
            cmux("set-progress", "0", "--label", `${info.total} tasks queued`);
          }
          break;
        }

        case "session.idle":
          cmux("set-status", "opencode", "Waiting for input", "--color", "#8e8e93", "--icon", "circle");
          cmux("clear-progress");
          cmuxLog("info", "opencode", "Idle \u2014 waiting for input");
          break;

        case "session.deleted":
          cmux("clear-status", "opencode");
          cmux("clear-progress");
          break;
      }
    },
  };
};

export { CMUXSidebarProgress };
export default CMUXSidebarProgress;
