<script lang="ts">
	import Tabs from '@components/Tabs.svelte'
	import type { ITab } from '@typings/type'
	import Properties from '@components/Properties.svelte'
	import { REALTOR_GRADE, TEMP_HIDE, CONFIG } from '@store/stores'
	import Apartments from '@components/Apartments.svelte'

	let AvailableTabs: ITab[] = [
		{
			name: 'Properties',
			icon: 'fas fa-home',
			component: Properties,
		},
	]

	REALTOR_GRADE.subscribe((value) => {
		if (value >= $CONFIG.setApartments) {
			AvailableTabs.push({
				name: 'Apartments',
				icon: 'fas fa-building',
				component: Apartments,
			})
		}
	})

	let selectedTab: ITab = AvailableTabs[0]
</script>

<div
	class="w-[60%] h-[90%] bg-[color:var(--color-primary)] absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 flex flex-col"
	style="opacity: {$TEMP_HIDE ? "0" : "1"};"
>
	<div class="w-full h-full overflow-hidden">
		<svelte:component this={selectedTab.component} />
	</div>
	<Tabs bind:selectedTab {AvailableTabs} />
</div>
