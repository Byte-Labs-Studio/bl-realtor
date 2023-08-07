<script>
	import PropertyCard from "@components/properties/PropertyCard.svelte"
    import DropdownComponent from "@components/generic/DropdownComponent.svelte"
	import PropertyDetailsModal from "./PropertyDetailsModal.svelte"
	import ManagePropertyModal from "./ManagePropertyModal.svelte"

    const highLowDropdown = ['High to Low', 'Low to High'];
    let selectedHighLowValue = highLowDropdown[0];

    const forSaleDropdown = ['For Sale', 'All Properties'];
    let selectedForSaleValue = forSaleDropdown[0];

    const typeDropdown = ['House', 'Apartments'];
    let selectedTypeValue = typeDropdown[0];
</script>
<div class="properties-base">
    <div class="search-wrapper">
        <img src="/images/apts-bg.png" />

        <div class="search-data">
            <p>Find your next property purchase</p>
            <p class="light-text">From houses, to garages, to the best sales.</p>

            <div class="search-bar" >
                <input type="text" placeholder="Explore all real estate" />
                <i class="fas fa-magnifying-glass"></i>
            </div>
        </div>
    </div>

    <div class="properties-heading-wrapper">
        <p class="heading">All Properties Listed  </p>

        <div class="filters-wrapper">
            <DropdownComponent dropdownValues={highLowDropdown} label="" selectedValue={selectedHighLowValue} id="high-low-dd" />
            <DropdownComponent dropdownValues={forSaleDropdown} label="" selectedValue={selectedForSaleValue} id="for-sale-dd" />
            <DropdownComponent dropdownValues={typeDropdown} label="" selectedValue={selectedTypeValue} insideLabel="Type: " id="type-dd" />
        </div>
    </div>

    <div class="property-listing-wrapper">
        <PropertyCard id="property-card-1" />
        <PropertyCard id="property-card-2" />
        <PropertyCard id="property-card-3" />
        <PropertyCard id="property-card-4" />
        <PropertyCard id="property-card-5" />
        <PropertyCard id="property-card-6" />
    </div>

    <!-- <PropertyDetailsModal /> -->
    <!-- <ManagePropertyModal /> -->
</div>