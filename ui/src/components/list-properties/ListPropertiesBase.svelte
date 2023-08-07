<script lang="ts">
	import FormWrapperDropdown from "@components/generic/FormWrapperDropdown.svelte"
    import SetNotSetIndicator from "@components/generic/SetNotSetIndicator.svelte"
    import { PROPERTIES } from '@store/stores'
    import { ReceiveNUI } from '@utils/ReceiveNUI'
	import { SendNUI } from '@utils/SendNUI'
	import { SHELLS, TEMP_HIDE } from '@store/stores'
    import { fly } from 'svelte/transition';

    let existingProperties = $PROPERTIES;
    let addingNewProperty = false;
</script>

{#if existingProperties.length <= 0 && !addingNewProperty}
    <div class="no-new-properties-base">
        <img src="/images/House.png" />

        <p>You haven't listed a property yet!</p>

        <button on:click={() => addingNewProperty = !addingNewProperty}>
            Add New Property
        </button>
    </div>
{:else}
    <div class="list-new-property-form">
        <div class="header">
            <div class="heading-title-wrapper">
                <i class="fas fa-circle-plus add-icon"></i>
                <p>List New Property</p>
            </div>
            <div>
                <i class="fas fa-chevron-down chevron-icon"></i>
            </div>
        </div>

        <div class="body-wrapper">
            <div class="left-column">
                <p class="title">Property Information</p>

                <p class="info">Some instructions lorem lpsum is simply dummy text of printing</p>
            </div>
            <div class="right-column">
                <div id="door-creation" class="form-row-wrapper">
                    <p class="label">Door Creation</p>
                
                    <div class="action-row">
                        <SetNotSetIndicator leftValue="Door" rightValue="Not Set" good={false} />
                        <button class="regular-button">Set Door</button>
                    </div>
                </div>

                <div id="garage-creation" class="form-row-wrapper">
                    <p class="label">Garage Creation</p>
                
                    <div class="action-row">
                        <SetNotSetIndicator leftValue="Garage" rightValue="Set" good={true} />
                        <button class="regular-button">Set Garage</button>
                    </div>
                </div>

                <div id="description" class="form-row-wrapper">
                    <p class="label">Description</p>
                
                    <div class="action-row">
                        <textarea rows="5" placeholder="Write a short and sweet description about yourself..." />
                    </div>
                </div>

                <div id="price" class="form-row-wrapper">
                    <p class="label">Price</p>
                
                    <div class="action-row">
                        <input type="text" placeholder="$1000000000" />
                    </div>
                </div>

                <div id="shell-type" class="form-row-wrapper">
                    <p class="label">Shell Type</p>
                
                    <div class="action-row">
                        <FormWrapperDropdown dropdownValues={[]} label="" id="new-listing-dd-shell-type" selectedValue="House" insideLabel="Type: " />
                    </div>
                </div>
            </div>
        </div>

        <div class="list-new-property-form-footer">
            <button>Create Property</button>
        </div>
    </div>
{/if}