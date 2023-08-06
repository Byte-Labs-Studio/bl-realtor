<script>
    export let id = "property-card-1"
</script>

<div class="property-card-wrapper group">
    <button class="invisible group-hover:visible absolute card-hover-button">
        View Property
    </button>
    
    <img src="/images/property-card-img.png" />

    <div class="property-card-details">
        <p class="property-name">Elgin Ave 2</p>
        <p class="property-address">Legion Square</p>
        <p class="property-cost">$ 10,000 USD</p>
        <div class="property-details">
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