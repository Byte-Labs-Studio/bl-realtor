import { writable } from "svelte/store";

export const visibility = writable<boolean>(false);
export const browserMode = writable<boolean>(false);
export const resName = writable<string>("");



export const PROPERTIES = writable<any[]>([]);
export const SHELLS = writable<any[]>([]);

export const IS_REALTOR = writable<boolean>(true);

export const TEMP_HIDE = writable<boolean>(false);
