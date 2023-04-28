<script lang="ts">
	import { debugData } from '../utils/debugData'
	import type { IProperty } from '@typings/type'

	let show = false
	//EXAMPLE

	// debugData([
	// 	{
	// 		action: 'setVisible',
	// 		data: true,
	// 	},
	// ])
	let properties: IProperty[] = []
	let debugProperty: IProperty = {
		property_id: 1,
		label: 'Test Property',
		description: 'This is a test property',
		shell: 'Standard Motel',
		extra_img: [
			{
				url: 'https://i.postimg.cc/g2PYn8XR/bathroom.webp',
				label: 'Bathroom',
			},
			{
				url: 'https://i.postimg.cc/zBMN5gYy/Bedroom.webp',
				label: 'Bedroom',
			},
			{
				url: 'https://i.postimg.cc/MTXwhYNk/entry.webp',
				label: 'Entrance',
			},
			{
				url: 'https://i.postimg.cc/GtyCpmbq/Kitchen-and-Dining.webp',
				label: 'Kitchen and Dining',
			},
			{
				url: 'https://i.postimg.cc/ThvX5vwG/living-room-1.webp',
				label: 'Living Room Angle 1',
			},
			{
				url: 'https://i.postimg.cc/dQkkCR1S/living-room-2.webp',
				label: 'Living Room Angle 2',
			},
		],
		price: Math.floor(Math.random() * 1000000),
		door: {
			x: 0,
			y: 0,
			z: 0,
			h: 0,
			length: 0,
			width: 0,
			locked: false,
		},
		garage: {
			x: 0,
			y: 0,
			z: 0,
		},
	}
	let options = [
		{
			component: 'Show',
			actions: [
				{
					name: 'show',
					action: 'setVisible',
					data: true,
				},
				{
					name: 'hide',
					action: 'setVisible',
					data: false,
				},
			],
		},
		{
			component: 'Properties',
			actions: [
				{
					name: "Add Property",
					custom: true,
					customFunction: () => {
						let newProperty = Object.assign({}, debugProperty)
						newProperty.property_id = properties.length + 1
						newProperty.label = `Test Property ${Math.floor(Math.random() * 1000000)}`
						newProperty.price = Math.floor(Math.random() * 1000000)
						let coords = {
							x: Math.floor(Math.random() * 1000000),
							y: Math.floor(Math.random() * 1000000),
							z: Math.floor(Math.random() * 1000000),
						}
						newProperty.garage = (Math.random() > 0.5 ? coords : null)
						properties = [...properties, newProperty]
						debugData([
							{
								action: 'setProperties',
								data: properties,
							},
						])
					},
				},
			],
		},
		// {
		// 	component: 'Example',
		// 	actions : [
		// 		{
		// 			name: "debugLocation",
		// 			custom: true,
		// 			customFunction: () => {
		// CUSTOM LOGIC
		// 			}
		// 		},
		// 		{
		// 			name: "toggle Show",
		// 			custom: true,
		// 			customFunction: () => {
		// CUSTOM LOGIC
		// 			}
		// 		},
		// 	]
		// },
	]
</script>

<div class="absolute top-0 left-1/2 z-[1000]">
	<button
		class="bg-red-500 text-white p-2"
		on:click={() => {
			show = !show
		}}
	>
		Show
	</button>
	{#if show}
		<div class="w-fit h-fit bg-gray-600 p-2">
			{#each options as option}
				<div class="flex flex-row gap-2 items-center m-1">
					<p class="text-white">{option.component}</p>
					{#each option.actions as action}
						<button
							class="bg-blue-500 text-white p-2"
							on:click={() => {
								if (action.custom == true) {
									action.customFunction()
									return
								}
								debugData([
									{
										action: action.action,
										data: action.data,
									},
								])
							}}
						>
							{action.name}
						</button>
					{/each}
				</div>
			{/each}
		</div>
	{/if}
</div>
