<script lang="ts">
	import { afterUpdate, onDestroy, onMount } from 'svelte'
	import { fly } from 'svelte/transition'
	import ApartmentCard from './ApartmentCard.svelte';
	import ApartmentModal from './ApartmentModal.svelte'
	import type { IApartment } from '@typings/type'
	import { APARTMENTS } from '@store/stores'

	let selectedApartment: IApartment | null = null

	let El: HTMLElement // The element that will be scrolled
	let initial: boolean = true // If the scroll position has been set
	afterUpdate(() => {
		// Get the scroll position from the session storage
		if (initial) {
			initial = false
			const scrollPosition =
				sessionStorage.getItem('apartmentsScrollPosition') || 0
			// If there is a scroll position, scroll to it
			if (scrollPosition) {
				El.scrollTop = parseInt(scrollPosition)
			}
		}
	})

	onDestroy(() => {
		const scrollTop = El.scrollTop
		sessionStorage.setItem('apartmentsScrollPosition', scrollTop.toString())
	})

</script>

{#if selectedApartment}
	<ApartmentModal bind:selectedApartment />
{/if}

<div
	class="w-full h-full pt-[2rem] gap-[0rem] z-[10] items-center flex flex-col"
>
	<!-- ACTUAL CONTENT -->
	<div
		bind:this={El}
		class="w-full h-full relative flex py-[5rem] pb-[8rem] flex-row flex-grow flex-shrink gap-4 flex-wrap items-start justify-center overflow-y-scroll scroll-style scroll-style-vertical"
	>
		{#each $APARTMENTS as apartment, i}
			<ApartmentCard bind:selectedApartment apartment={apartment} />
		{/each}
	</div>
</div>
