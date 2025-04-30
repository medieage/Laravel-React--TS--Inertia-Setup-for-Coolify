import { PageProps as InertiaPageProps } from '@inertiajs/core';

declare module '@inertiajs/core' {
  interface PageProps {
    auth: {
      user: User;
    };
    [key: string]: any;
  }
}

export interface User {
  id: number;
  name: string;
  email: string;
  email_verified_at?: string;
}

export type PageProps<T = {}> = InertiaPageProps & T;
