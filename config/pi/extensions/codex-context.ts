import { readFile, writeFile } from "node:fs/promises";
import { homedir } from "node:os";
import { join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const PROVIDER_ID = "openai-codex";
const CONTEXTS = {
	"gpt-5.4": { long: 1_000_000, label: "1m" },
	"gpt-5.5": { long: 1_000_000, label: "1m" },
	"gpt-5.6-luna": { long: 1_050_000, label: "1.05m" },
	"gpt-5.6-sol": { long: 1_050_000, label: "1.05m" },
	"gpt-5.6-terra": { long: 1_050_000, label: "1.05m" },
} as const;
const SHORT_CONTEXT = 272_000;

type ModelId = keyof typeof CONTEXTS;
type ModelsConfig = {
	providers?: Record<string, { modelOverrides?: Record<string, { contextWindow?: number }> }>;
};

function agentDir(): string {
	return process.env.PI_CODING_AGENT_DIR ?? join(homedir(), ".pi", "agent");
}

export default function (pi: ExtensionAPI) {
	pi.registerCommand("codex-context", {
		description: "Switch the selected Codex model between short and long context",
		handler: async (args, ctx) => {
			await ctx.waitForIdle();

			const modelId = ctx.model?.id;
			if (ctx.model?.provider !== PROVIDER_ID || !modelId || !(modelId in CONTEXTS)) {
				ctx.ui.notify("Select GPT-5.4, GPT-5.5, or GPT-5.6 Codex first.", "error");
				return;
			}

			const requested = args.trim().toLowerCase();
			if (requested && requested !== "long" && requested !== "short") {
				ctx.ui.notify("Usage: /codex-context [long|short]", "error");
				return;
			}

			const context = CONTEXTS[modelId as ModelId];
			const long = requested === "long" || (!requested && ctx.model.contextWindow === SHORT_CONTEXT);
			const modelsPath = join(agentDir(), "models.json");
			const config = JSON.parse(await readFile(modelsPath, "utf8")) as ModelsConfig;
			const provider = (config.providers ??= {})[PROVIDER_ID] ??= {};
			const override = (provider.modelOverrides ??= {})[modelId] ??= {};
			override.contextWindow = long ? context.long : SHORT_CONTEXT;
			await writeFile(modelsPath, `${JSON.stringify(config, null, 2)}\n`);

			await ctx.modelRegistry.refresh({ allowNetwork: false });
			const model = ctx.modelRegistry.find(PROVIDER_ID, modelId);
			if (!model || !(await pi.setModel(model))) {
				throw new Error(`Unable to select ${PROVIDER_ID}/${modelId}`);
			}
			ctx.ui.notify(`${modelId} context: ${long ? context.label : "272k"}`, "info");
		},
	});
}
