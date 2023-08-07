<script lang="ts">
	import FormWrapperDropdown from '@components/generic/FormWrapperDropdown.svelte'
    import SetNotSetIndicator from '@components/generic/SetNotSetIndicator.svelte'
    import { fade } from 'svelte/transition';

    export let manageProperty: boolean=false;
</script>

<div class="modal large-footer-modal" tabindex="-1" aria-hidden="true" transition:fade="{{duration: 100}}">
    <div class="modal-dialog large-footer-modal-dialog manage-property-modal-dialog">
        <div class="modal-content large-footer-modal-content">
            <div class="modal-body large-footer-modal-body">
                
                <div class="header">
                    <div class="heading-title-wrapper">
                        <i class="fas fa-pen info-icon"></i>
                        <p>Manage Property</p>
                    </div>
                    <div on:click={() => manageProperty = false}>
                        <i class="fas fa-xmark close-icon"></i>
                    </div>
                </div>

                <div class="large-footer-modal-body-data manage-property-large-footer-modal-body-data">
                     <div class="data-details-manage-property">
                        <div class="left-column">
                            <p class="heading">
                                Live Description
                            </p>
                            <p class="info">
                                Some instructions lorem lpsum is simply dummy text of printing
                            </p>
                        </div>

                        <div class="right-column">
                            <div id="sell-property" class="form-row-wrapper">
                                <p class="label">Sell Property</p>
                            
                                <div class="action-row">
                                    <SetNotSetIndicator leftValue="Set" rightValue="For Sale" good={true} />
                                    
                                    <div style="margin-left: 0.5vw;">
                                        <FormWrapperDropdown dropdownValues={['For Sale']} label="" insideLabel="Change: " selectedValue="For Sale" />
                                    </div>
                                    
                                </div>
                            </div>

                            <div id="finalize-sell-property" class="form-row-wrapper">
                                <p class="label">Finalize Sell Property</p>
                            
                                <div class="action-row">
                                    <SetNotSetIndicator leftValue="Not Set" rightValue="" good={false} />
                                    <input type="text" placeholder="ID: 34343434343" style="width: 10vw;" />
                                </div>
                            </div>

                            <div id="manage-description" class="form-row-wrapper">
                                <p class="label">Manage Description</p>
                            
                                <div class="action-row">
                                    <textarea rows="3" placeholder="Write a short and sweet description about yourself..." style="width: 18vw;" />
                                </div>
                            </div>

                            <div id="manage-price" class="form-row-wrapper">
                                <p class="label">Manage Price</p>
                            
                                <div class="action-row">
                                    <input type="text" placeholder="$1000000000" style="width: 10vw;" />
                                </div>
                            </div>

                            <div id="manage-shell-type" class="form-row-wrapper">
                                <p class="label">Manage Shell</p>
                            
                                <div class="action-row">
                                    <FormWrapperDropdown dropdownValues={[]} label="" id="manage-dd-shell" selectedValue="House" insideLabel="Type: " />
                                </div>
                            </div>

                            <div id="add-images" class="form-row-wrapper" style="margin-top: 2vw">
                                <p class="label">Add Images</p>
                            
                                <div class="action-row">
                                    <input id="img-name" type="text" placeholder="Name" style="width: 7vw;" />
                                    <input id="img-url" type="text" placeholder="URL" style="width: 7vw;" />
                                    <button class="regular-button">Add</button>
                                </div>

                                <div class="image-tiles-wrapper">
                                    <div>
                                        <img src="/images/apt-card-img.png" />
                                    </div>
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                </div>
                            </div>

                            <div id="manage-door" class="form-row-wrapper">
                                <p class="label">Manage Door</p>
                            
                                <div class="action-row">
                                    <SetNotSetIndicator leftValue="Door" rightValue="Set" good={true} />
                                    <button class="regular-button">New Location</button>
                                    <button class="disable-button">Remove</button>
                                </div>
                            </div>
                
                            <div id="manage-garage" class="form-row-wrapper">
                                <p class="label">Manage Garage</p>
                            
                                <div class="action-row">
                                    <SetNotSetIndicator leftValue="Garage" rightValue="Set" good={true} />
                                    <button class="regular-button">New Location</button>
                                    <button class="disable-button">Remove</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="large-footer-modal-footer-manage-property">
                    <button class="delete-button">
                        Delete Property
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>