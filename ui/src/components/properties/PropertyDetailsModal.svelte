<script>
    import { fade } from 'svelte/transition';
</script>

<div class="modal large-footer-modal" tabindex="-1" aria-hidden="true" transition:fade="{{duration: 100}}">
    <div class="modal-dialog large-footer-modal-dialog">
        <div class="modal-content large-footer-modal-content">
            <div class="modal-body large-footer-modal-body">
                
                <div class="header">
                    <div class="heading-title-wrapper">
                        <i class="fas fa-circle-info info-icon"></i>
                        <p>Property Details</p>
                    </div>
                    <div>
                        <i class="fas fa-xmark close-icon"></i>
                    </div>
                </div>

                <div class="large-footer-modal-body-data">
                    <img src="/images/apts-bg.png" />

                    <div class="data-details">
                        <div class="left-column">
                            <p class="property-name">
                                Elgin Ave 2
                            </p>

                            <p class="property-info">
                                The Basic Tee 6-Pack allows you to fully express your vibrant personality with three grayscale options. Feeling adventurous?
                            </p>

                            <div class="gallery-image-wrapper">
                                <img src="/images/apts-bg.png" />
                                <img src="/images/apts-bg.png" />
                                <img src="/images/apts-bg.png" />
                                <img src="/images/apts-bg.png" />
                            </div>
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

                <div class="large-footer-modal-footer">
                    <button>Manage Property</button>
                </div>
            </div>
        </div>
    </div>
</div>