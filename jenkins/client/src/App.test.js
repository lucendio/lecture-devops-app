import React from 'react';
import { render, waitForElement, fireEvent } from '@testing-library/react';
import App from './App';

// NOTE: suppress virtual console output
console.error = ()=>{};


test.skip('renders header title "ToDo App"', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/ToDo App/i);
  expect(linkElement).toBeInTheDocument();
});

test('renders a header container', () => {
  const { container } = render(<App />);
  const header = container.querySelector('.header-main')
  expect(header).toHaveTextContent(/.+/);
});

test('renders a login form', async () => {
  const { getByText } = render(<App />);
  await waitForElement(() => getByText(/Sign in/i));
  await waitForElement(() => getByText(/Email/i));
  await waitForElement(() => getByText(/Password/i));
  await waitForElement(() => getByText(/Login/i));
});

test('renders registration form when register button clicked', async () => {
  const { getByText } = render(<App />);
  await waitForElement(() => getByText(/Signup/i));
  fireEvent.click(getByText('Signup'));
  await waitForElement(() => getByText(/Your name/i));
  await waitForElement(() => getByText(/Your email/i));
  await waitForElement(() => getByText(/Your password/i));
  await waitForElement(() => getByText(/Create User/i));
});
