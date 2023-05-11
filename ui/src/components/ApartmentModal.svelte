<script lang="ts">
    import type { IApartment } from "@typings/type";
    import { fade } from "svelte/transition";
    import { REALTOR_GRADE, CONFIG } from "@store/stores";
	import Information from "./ApartmentModal/Information.svelte"
	import CurrentTenants from "./ApartmentModal/CurrentTenants.svelte"
	import EditOptions from "./ApartmentModal/EditOptions.svelte"

    export let selectedApartment: IApartment | null = null

</script>


{#if (selectedApartment !== null)}
	<div
		class="absolute w-full h-full grid place-items-center bg-[rgba(0,0,0,0.5)] z-[99999999999]"
		transition:fade={{ duration: 250 }}
	>
		<div
			class="w-[60%] h-[95%] bg-[color:var(--color-secondary)] flex flex-col p-5 overflow-y-scroll scroll-style scroll-style-vertical"
		>
			<button
				class="absolute top-5 left-5 grid place-items-center w-16 h-16 bg-[color:var(--color-secondary)] text-[color:var(--color-accent)]"
				on:click={() => (selectedApartment = null)}
			>
				<i class="fas fa-times" />
			</button>

			<h1
				class="text-4xl text-center font-bold w-full py-4 h-fit bg-[color:var(--color-tertiary)]"
			>
				Apartment Details
			</h1>
			<h2 class="text-3xl text-center font-bold pt-4">
				{selectedApartment.apartmentData.label}
			</h2>

			<div
				class="w-full flex h-full flex-row items-start justify-between pt-[4rem]"
			>
				<div
					class="flex flex-col justify-start max-h-[65rem] items-start w-full overflow-y-scroll scroll-style scroll-style-vertical"
				>
                    <!-- I dont know what else to put in the information section. If you have any idea pr or issue -->
                    <!-- Information -->
                    <Information {selectedApartment} />

                    <!-- {#if $REALTOR_GRADE >= $CONFIG.setApartments} -->
                    <!-- Assign new tenant -->
                    <EditOptions {selectedApartment} />
                    <!-- {/if} -->

				</div>
                <CurrentTenants {selectedApartment} />
			</div>
		</div>
	</div>
{/if}
