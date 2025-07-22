// Generate or retrieve visitor ID
function getVisitorId() {
    let visitorId = localStorage.getItem('visitorId');
    
    if (!visitorId) {
        visitorId = 'visitor_' + Date.now() + '_' + Math.random().toString(36).substring(2, 11);
        localStorage.setItem('visitorId', visitorId);
        console.log('[VisitorCounter] Generated new visitor ID:', visitorId);
    } else {
        console.log('[VisitorCounter] Using existing visitor ID:', visitorId);
    }

    return visitorId;
}


// Update visitor count
async function updateVisitorCount() {
    const countElement = document.getElementById('visitor-count');

    console.log('[DEBUG] Running updateVisitorCount');

    if (!countElement) {
        console.warn('[DEBUG] Element with id "visitor-count" not found');
        return;
    }

    try {
        const configResponse = await fetch('/config.json');
        console.log('[DEBUG] Fetched config.json');

        const config = await configResponse.json();
        const API_URL = config.apiUrl;

        const visitorId = getVisitorId();
        console.log('[DEBUG] Visitor ID:', visitorId);
        console.log('[DEBUG] Calling API:', `${API_URL}?visitorId=${encodeURIComponent(visitorId)}`);

        const response = await fetch(`${API_URL}?visitorId=${encodeURIComponent(visitorId)}`);

        if (response.ok) {
            const data = await response.json();
            console.log('[DEBUG] Visitor count response:', data);
            countElement.textContent = data.count;
        } else {
            throw new Error(`HTTP ${response.status}`);
        }
    } catch (error) {
        console.error('[DEBUG] Error updating visitor count:', error);
        countElement.textContent = 'Error';
    }

}

// Delay visitor count update to ensure Cypress/localStorage is ready
function deferUpdateVisitorCount() {
    setTimeout(updateVisitorCount, 100);  // Slight delay to allow test setup
}

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', deferUpdateVisitorCount);
} else {
    deferUpdateVisitorCount();
}
