describe('Cloud Resume E2E', () => {
  const baseUrl = Cypress.config('baseUrl');
  const apiUrl = Cypress.env('apiUrl');

  const testIds = {
    consistent: 'cypress-test-consistent',
    new: `cypress-test-new-${Date.now()}`,
    e2e: 'cypress-test-e2e-workflow',
    filter: 'cypress-test-filter-check'
  };

  beforeEach(() => {
    cy.window().then((win) => {
      win.localStorage.clear();
      win.localStorage.setItem('visitorId', testIds.consistent);
    });
  });

  it('serves the static resume', () => {
    cy.visit('/');
    cy.contains('application').should('be.visible');
  });

  it('displays visitor count on the page', () => {
    cy.visit('/');
    cy.get('#visitor-count', { timeout: 10000 }).should(($el) => {
      const text = $el.text();
      expect(text).to.not.contain('Error');
      expect(text).to.match(/^\d+$/, `Expected numeric visitor count, got: ${text}`);
    });
  });

  it('returns consistent response for test visitor', () => {
    cy.request(`${apiUrl}?visitorId=${testIds.consistent}`).then((res) => {
      expect(res.status).to.eq(200);
      expect(res.body).to.have.property('count').that.is.a('number');
    });
  });

  it('handles new test visitor IDs', () => {
    cy.request(`${apiUrl}?visitorId=${testIds.new}`).then((res) => {
      expect(res.status).to.eq(200);
      expect(res.body).to.have.property('count').that.is.a('number');
    });
  });

  it('validates API response structure', () => {
    cy.request({
      method: 'GET',
      url: `${apiUrl}?visitorId=${testIds.consistent}`,
      failOnStatusCode: false
    }).then((res) => {
      expect(res.status).to.eq(200);
      expect(res.body).to.have.property('count').that.is.a('number');
    });
  });

  it('handles empty visitor ID gracefully', () => {
    cy.request({
      method: 'GET',
      url: `${apiUrl}?visitorId=`,
      failOnStatusCode: false
    }).then((res) => {
      expect([200, 400]).to.include(res.status);
    });
  });

  it('verifies config.json is deployed correctly', () => {
    cy.request('/config.json').then((res) => {
      expect(res.status).to.eq(200);
      expect(res.body).to.have.property('apiUrl').that.includes('azurewebsites.net');
      expect(res.body.apiUrl).to.eq(apiUrl);
    });
  });

  it('completes full visitor workflow with test data', () => {
    cy.window().then((win) => {
      win.localStorage.setItem('visitorId', testIds.e2e);
    });

    cy.visit('/');

    cy.get('#visitor-count', { timeout: 10000 }).should(($el) => {
      const text = $el.text();
      expect(text).to.not.contain('Error');
      expect(text).to.match(/^\d+$/, `Expected numeric visitor count, got: ${text}`);
    });
  });

  it('verifies test traffic is filtered (mock response)', () => {
    cy.request(`${apiUrl}?visitorId=${testIds.filter}`).then((res) => {
      expect(res.status).to.eq(200);
      expect(res.body.count).to.eq(42); // Assuming mock data is always 42
    });
  });
});
