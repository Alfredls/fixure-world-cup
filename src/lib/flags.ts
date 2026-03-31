import type { ImageMetadata } from 'astro';

const images = import.meta.glob<{ default: ImageMetadata }>('/src/assets/flags/*.{png,jpg,jpeg,svg}', { eager: true });

export function resolveFlag(flagName: string): ImageMetadata | string {
    if (flagName.startsWith('http')) return flagName;
    const path = `/src/assets/flags/${flagName}`;
    return images[path] ? images[path].default : images['/src/assets/flags/unk.png'].default;
}
