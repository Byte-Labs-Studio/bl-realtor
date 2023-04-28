<script lang="ts">
	import type { ITab } from '@typings/type'

	export let AvailableTabs: ITab[] = []
	/* The current Selected Tab */
	export let selectedTab: ITab = AvailableTabs[0]
</script>

<div
	class="w-full h-fit p-4 bg-[color:var(--color-secondary)] flex flex-row gap-4 items-center justify-center"
>
	{#each AvailableTabs as tab}
		<button
			class="w-fit px-8 h-[5rem] bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4"
			class:active={selectedTab.name == tab.name}
			on:click={() => (selectedTab = tab)}
		>
			<i class={tab.icon} />
			<p>{tab.name}</p>
		</button>
	{/each}
</div>

<style>
	.active {
		background-color: var(--color-accent);
	}
</style>
