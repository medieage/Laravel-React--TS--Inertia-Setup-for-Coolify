/**
 * Types for global functions available in Laravel/Inertia
 */

interface RouteFunction {
  (): {
    current: (name: string) => boolean;
    toString: () => string;
  };
  (name: string, params?: Record<string, any>, absolute?: boolean): string;
}

declare function route(): {
  current: (name: string) => boolean;
  toString: () => string;
};

declare function route(name: string, params?: Record<string, any>, absolute?: boolean): string;

// Extending the global Window object
declare global {
  const route: RouteFunction;

  interface Window {
    route: RouteFunction;
  }
}
