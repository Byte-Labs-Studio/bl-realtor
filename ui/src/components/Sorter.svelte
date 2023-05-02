<script lang="ts">
	import { REALTOR_GRADE, PROPERTIES } from "@store/stores"
	import type { IProperty } from "@typings/type"
    import { fly } from "svelte/transition"

    export let Properties: IProperty[] = $PROPERTIES
    let filterSale: boolean = true
    let lowToHigh: boolean = true
    let searchTerm: string = ""
    let onlyGarage: boolean = false

    $: {
        if (searchTerm || lowToHigh || onlyGarage || filterSale || $PROPERTIES) {
            filter()
        }
    }

    function filter() {
        let properties: IProperty[] = $PROPERTIES
        properties = filterForSale(properties)
        properties = filterGarage(properties)
        properties = filterPriceSort(properties)
        properties = filterSearch(properties)
        Properties = properties
    }

    function filterForSale(properties: IProperty[]) {
        // filter properties that have for_sale = 1 or true
        if (!filterSale) return properties
        properties = properties.filter((property) => property.for_sale)
        return properties
    }

    function filterSearch(properties: IProperty[]) {
        if (searchTerm.length < 1) return properties
        properties = properties.filter((property) => {
                const labelFilter = property.label.toLowerCase().includes(searchTerm.toLowerCase())
                const descriptionFilter = property.description.toLowerCase().includes(searchTerm.toLowerCase())
                const shellFilter = property.shell.toLowerCase().includes(searchTerm.toLowerCase())
                return labelFilter || descriptionFilter || shellFilter
        })
        return properties
    }

    function filterPriceSort(properties: IProperty[]) {
        if (lowToHigh) {
            properties = properties.sort((a, b) => a.price - b.price)
        } else {
            properties = properties.sort((a, b) => b.price - a.price)
        }
        return properties
    }

    function filterGarage(properties: IProperty[]) {
        if (!onlyGarage) return properties
        properties = properties.filter((property) => property.garage_data) // Only return properties with garage
        return properties
    }

</script>



<div class="w-full h-fit flex flex-row item-center justify-center relative gap-8 mb-4"
in:fly={{ y: 10, duration: 250 }}
>

    <!-- Search -->
    <div class="flex flex-row items-center bg-[color:var(--color-secondary)]"
    style="background-color: var(--color-{searchTerm.length>0?"accent":"secondary"});"
    >
        
        <div class="grid place-items-center aspect-square p-4">
            <i class="fas fa-search "></i>
        </div>

        <input bind:value={searchTerm} type="text" placeholder="Search" class="w-[20rem] h-full bg-[color:var(--color-tertiary)] p-2" />
    </div>

    <!-- Sort -->
    <button class="flex flex-row items-center gap-4 px-4"
        style="background-color: var(--color-{!lowToHigh?"accent":"secondary"});"
        on:click={() => lowToHigh = !lowToHigh}
    >
        <div class="grid place-items-center aspect-square"
        >
            <i class="fas fa-caret-{lowToHigh?"up":"down"}"></i>
        </div>
        <div class="grid place-items-center w-[8rem]"
            >
            <p class="text-xl"> <i class="fas fa-dollar-sign" /> {lowToHigh?"Low to High":"High to Low"}</p>
        </div>
    </button>

    <!-- Garage -->
    <button class="flex flex-row items-center"
        style="background-color: var(--color-{onlyGarage?"accent":"secondary"});"
        on:click={() => onlyGarage = !onlyGarage}>
        <div class="grid place-items-center aspect-square p-4">
            <i class="fas fa-warehouse"></i>
        </div>
    </button>

    <!-- For Sale -->
    {#if $REALTOR_GRADE !== null}
        <button class="flex flex-row items-center gap-4 px-4"
            style="background-color: var(--color-{!filterSale?"accent":"secondary"});"
            on:click={() => filterSale = !filterSale}
        >
            <div class="grid place-items-center w-[8rem]"
                >
                <p class="text-xl flex flex-row items-center justify-center"> <i class="fas fa-dollar-sign" /> {filterSale?"For Sale Only":"All Properties"}</p>
            </div>
        </button>
    {/if}
</div>