<script lang="ts">
	import FormWrapperDropdown from '@components/generic/FormWrapperDropdown.svelte'
    import SetNotSetIndicator from '@components/generic/SetNotSetIndicator.svelte'
    import { TEMP_HIDE, PROPERTIES, SHELLS, REALTOR_GRADE, CONFIG, } from '@store/stores'
    import type { IApartment } from '@typings/type'
	import { SendNUI } from '@utils/SendNUI'
	import { createEventDispatcher, onMount } from 'svelte'
    import { fade } from 'svelte/transition';

    const dispatch = createEventDispatcher();

    export let selectedApartment: IApartment | null = null;

    let tenants: string[] = [], tenantsResult: string[] = [];
    let searchTerm: string = "";

    onMount(()=>{
        const  apartmentName: string = selectedApartment.apartmentData.label as string
        
        // search PROPERTIES for all the properties that have the same apartment name and return the owner
        const arrCitizenids = $PROPERTIES.filter((property) => property.apartment === apartmentName).map((property) => property.owner)
        if (arrCitizenids.length === 0 || arrCitizenids[0] === undefined) {
            tenantsResult = []
            return
        }

        SendNUI('getNames', arrCitizenids).then((names: string[]) => {
            tenants = names
        })
    });

    $: {
        if (searchTerm.length > 0) {
            tenantsResult = tenants.filter((tenant) => tenant.toLowerCase().includes(searchTerm.toLowerCase())) || []
        } else {
            tenantsResult = tenants || [];
        }
    }

    console.log('selected-apartment: ', selectedApartment)
</script>

{#if selectedApartment !== null}
    <div class="modal large-footer-modal" tabindex="-1" aria-hidden="true" transition:fade="{{duration: 100}}">
        <div class="modal-dialog large-footer-modal-dialog selected-apartment-modal-dialog">
            <div class="modal-content large-footer-modal-content">
                <div class="modal-body large-footer-modal-body">
                    
                    <div class="header">
                        <div class="heading-title-wrapper">
                            <i class="fas fa-circle-info info-icon"></i>
                            <p>Apartment Details</p>
                        </div>
                        <div on:click={() => selectedApartment = null}>
                            <i class="fas fa-xmark close-icon"></i>
                        </div>
                    </div>

                    <div class="large-footer-modal-body-data selected-apartment-large-footer-modal-body-data">
                        <div class="data-details-selected-apartment">
                            <img src='/images/apts-bg.png' />

                            <div class="search-wrapper">
                                <div class="apt-details">
                                    <p class="heading">{selectedApartment.apartmentData.label}</p>
                                    <p class="tenant-count">{tenantsResult.length.toLocaleString()} Tenants</p>
                                </div>

                                <div class="search-actions">
                                    <div class="search-bar">
                                        <input placeholder="Search Tenant" bind:value={searchTerm} />
                                        <i class="fas fa-magnifying-glass"></i>
                                    </div>
                                    <button>
                                        <i class="fas fa-location-dot"></i>Set Waypoint
                                    </button>
                                </div>
                            </div>

                            <hr />

                            <div class="tenant-wrapper">
                                {#each tenantsResult as tenant}
                                    <div class="tenant-row">
                                        <div class="img-wrapper">

                                        </div>

                                        <div class="tenant-details">
                                            <p class="tenant-name">{tenant}</p>
                                            <p class="tenant-status">Current Tenant</p>
                                        </div>
                                    </div>
                                {/each}
                            </div>
                        </div>
                    </div>

                    <div class="large-footer-modal-footer-selected-apartment">
                        <input placeholder="New ID" />
                        <button class="add-button">
                            Add
                        </button>
                        <!-- {#if $REALTOR_GRADE >= $CONFIG.deleteProperty}
                            <button class="delete-button" on:click={deleteProperty}>
                                Delete Property
                            </button>
                        {/if} -->
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}