import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    summary: z.string().optional(),
    draft: z.boolean().default(false),
  }),
});

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    name: z.string(),
    tagline: z.string(),
    status: z.enum(['live', 'in progress', 'brewing', 'archived']),
    stack: z.array(z.string()),
    order: z.number().default(99),
    hidden: z.boolean().default(false),
  }),
});

export const collections = { blog, projects };
