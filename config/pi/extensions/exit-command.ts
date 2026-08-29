import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/** Provides a /exit compatibility command with the same shutdown behavior as /quit. */
export default function (pi: ExtensionAPI) {
	pi.registerCommand("exit", {
		description: "Exit Pi (same behavior as /quit)",
		handler: async (_args, ctx) => {
			ctx.shutdown();
		},
	});
}
