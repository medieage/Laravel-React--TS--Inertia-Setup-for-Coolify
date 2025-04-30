import axios from 'axios';

// Extending the global Window interface for TypeScript
declare global {
    interface Window {
        axios: any; // Using any to bypass strict typing in this case
    }
}

// Initialize axios as a global object
window.axios = axios;

// Configure default HTTP headers
window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// Add CSRF token to each request
const token = document.head.querySelector('meta[name="csrf-token"]');

if (token) {
    window.axios.defaults.headers.common['X-CSRF-TOKEN'] = (token as HTMLMetaElement).content;
} else {
    console.error('CSRF token not found: https://laravel.com/docs/csrf#csrf-x-csrf-token');
}
