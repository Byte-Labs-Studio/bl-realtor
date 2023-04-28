<script lang="ts">
	import { IS_REALTOR, PROPERTIES } from "@store/stores"
	import type { IProperty } from "@typings/type"
	import { afterUpdate, onDestroy, onMount } from "svelte"
	import Sorter from "./Sorter.svelte"

    let Properties: IProperty[] = [];

    let El: HTMLElement; // The element that will be scrolled
    let initial: boolean = true; // If the scroll position has been set
    afterUpdate(() => {
        // Get the scroll position from the session storage
        if (initial) {
            initial = false;
            const scrollPosition = sessionStorage.getItem("propertiesScrollPosition") || 0;
            // If there is a scroll position, scroll to it
            if (scrollPosition) {
                El.scrollTop = parseInt(scrollPosition);
            }
        }
    })

    onDestroy(() => {
        const scrollTop = El.scrollTop;
        sessionStorage.setItem("propertiesScrollPosition", scrollTop.toString());
        console.log("Saved scroll position: ", scrollTop);
    })

</script>

<div class="w-full h-full pt-[3rem] gap-[4rem]">

    <Sorter bind:Properties />

    <!-- ACTUAL CONTENT -->
    <div bind:this={El} class="w-full h-full relative flex py-[5rem] pb-[8rem] flex-row flex-grow flex-shrink gap-4 flex-wrap items-center justify-center overflow-y-scroll scroll-style scroll-style-vertical ">
        {#each Properties as {label, description, price, extra_img, shell, garage}, i}
            <button class="flex item flex-col w-[30%] h-fit bg-[color:var(--color-secondary)] hover:brightness-110">
                <img src="https://i.postimg.cc/q7PQTJZk/motel.webp" alt="" class="w-full h-[20rem] object-cover object-center">
                <div class="flex flex-col flex-grow flex-shrink gap-4 p-4">
                    <h1 class="text-2xl font-bold">{label}</h1>
                    <p class="text-xl">{description}</p>

                    <!-- Chips -->
                    <div class="flex flex-row flex-grow flex-wrap flex-shrink gap-4 items-center justify-start">
                        <div class="w-fit px-4 h-[3rem]  bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4">
                            <i class="fas fa-dollar-sign"></i>
                            <p>{price.toLocaleString()}</p>
                        </div>
                        <div class="w-fit px-4 h-[3rem]  bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4">
                            <i class="fas fa-image"></i>
                            <p>{extra_img.length}</p>
                        </div>
                        <div class="w-fit px-4 h-[3rem]  bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4">
                            <i class="fas fa-tent"></i>
                            <p>{shell}</p>
                        </div>
                        <div class="w-fit px-4 h-[3rem]  bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4">
                            <i class="fas fa-warehouse"></i>
                            <p>{garage?"Yes":"No"}</p>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <!-- <div class="flex flex-row flex-grow flex-shrink gap-4 items-center justify-center">
                        {#if $IS_REALTOR}
                            <button class="w-fit px-8 h-[5rem]  bg-[color:var(--color-tertiary)] items-center justify-center flex flex-row gap-4">
                                <i class="fas fa-pen"></i>
                                <p>Edit</p>
                            </button>
                        {/if}
                    </div> -->
                </div>
            </button>
        {/each}
    </div>
</div>

<style>

    .item {
        border: 5px solid var(--color-secondary);
    }
</style>