<script lang="ts">
	import Tabs from './Tabs.svelte'
	import type { ITab } from '@typings/type'
	import Properties from './Properties.svelte'
	import { afterUpdate, onDestroy, onMount } from 'svelte'

	let AvailableTabs: ITab[] = [
		{
			name: 'Properties',
			icon: 'fas fa-home',
			component: Properties,
		},
		{
			name: 'Job',
			icon: 'fas fa-briefcase',
			component: null,
		},
	]

	let selectedTab: ITab = AvailableTabs[0]
</script>

<div
	class="w-[90%] h-[90%] bg-[color:var(--color-primary)] absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 flex flex-col"
>
	<div class=" w-full h-full overflow-hidden">
		<svelte:component this={selectedTab.component} />
	</div>
	<Tabs bind:selectedTab {AvailableTabs} />
</div>
