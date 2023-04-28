<script lang="ts">
	import { PROPERTIES } from "@store/stores"
	import type { IProperty } from "@typings/type"

    export let Properties: IProperty[] = $PROPERTIES



    let sortType: string = "asc"
    let searchTerm: string = ""

    $: {
        if (searchTerm || sortType) {
            Properties = sortPrice(sortType)
        }
    }

    function returnSearch(term: string, properties: IProperty[]) {
        properties = properties.filter((property) => {
                const labelFilter = property.label.toLowerCase().includes(searchTerm.toLowerCase())
                const descriptionFilter = property.description.toLowerCase().includes(searchTerm.toLowerCase())
                const shellFilter = property.shell.toLowerCase().includes(searchTerm.toLowerCase())
                return labelFilter || descriptionFilter || shellFilter
        })
        return properties
    }

    function sortPrice(type: string) {
        sortType = type
        let properties: IProperty[] = []
        if (type == "asc") {
            properties = $PROPERTIES.sort((a, b) => a.price - b.price)
        } else if (type == "desc") {
            properties = $PROPERTIES.sort((a, b) => b.price - a.price)
        }
        return returnSearch(searchTerm, properties)
    }

</script>



<div class="w-full h-fit flex flex-row item-center justify-center relative gap-8 mb-4">

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
    <div class="flex flex-row items-center"
        style="background-color: var(--color-{sortType.length>0?"accent":"secondary"});"
    >
        <div class="grid place-items-center aspect-square p-4"
        >
            <i class="fas fa-sort"></i>
        </div>

        <select class="w-[20rem] h-full bg-[color:var(--color-tertiary)] p-2" on:change={(e) => sortPrice(e.target.value)}>
            <option value="asc">Price: Low to High</option>
            <option value="desc">Price: High to Low</option>
        </select>
    </div>

</div>