<script>
    import { fade } from 'svelte/transition';
</script>

<div class="modal large-footer-modal" tabindex="-1" aria-hidden="true" transition:fade="{{duration: 100}}">
    <div class="modal-dialog large-footer-modal-dialog">
        <div class="modal-content large-footer-modal-content">
            <div class="modal-body large-footer-modal-body">
                
                <div class="header">
                    <div class="heading-title-wrapper">
                        <i class="fas fa-pen info-icon"></i>
                        <p>Manage Property</p>
                    </div>
                    <div>
                        <i class="fas fa-xmark close-icon"></i>
                    </div>
                </div>

                <div class="large-footer-modal-body-data">
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
                            <p class="title">$100,000 USD</p>

                            <button class="waypoint">
                                <i class="fas fa-location-dot"></i>
                                <p>Set Waypoint</p>
                            </button>

                            <div class="tiles-wrapper">
                                <div class="each-tile">
                                    <i class="fas fa-dollar-sign"></i>
                                    For Sale
                                </div>
                                <div class="each-tile">
                                    <i class="fas fa-image"></i>
                                    Gallery
                                </div>
                                <div class="each-tile">
                                    <i class="fas fa-bath"></i>
                                    Baths: 2
                                </div>
                                <div class="each-tile">
                                    <i class="fas fa-house-chimney"></i>
                                    House
                                </div>
                                <div class="each-tile">
                                    <i class="fas fa-truck-front"></i>
                                    Garage: Yes
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