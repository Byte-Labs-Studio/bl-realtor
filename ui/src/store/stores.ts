import { writable } from "svelte/store";

export const visibility = writable<boolean>(false);
export const browserMode = writable<boolean>(false);
export const resName = writable<string>("");



export const PROPERTIES = writable<any[]>([]);

export const IS_REALTOR = writable<boolean>(false);
// interface IProperty {
//     property_id: number;
//     label: string;
//     description: string;
//     extra


// export const 