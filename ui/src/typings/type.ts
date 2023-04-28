export interface ITab {
    name: string,
    icon: string,
    component: any
}

type coords = {
    x: number;
    y: number;
    z: number;
}

interface door extends coords {
    h: number;
    length: number;
    width: number;
    locked?: boolean;
}

type img = {
    url: string;
    label: string;
}

export interface IProperty {
    property_id: number;
    label: string;
    description: string;
    shell: string;
    extra_img: img[];
    price: number;
    door: door;
    garage: coords | null;
}
