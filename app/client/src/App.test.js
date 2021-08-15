import React from 'react';
import { render, waitFor, fireEvent } from '@testing-library/react';
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
  await waitFor(() => getByText(/Sign in/i));
  await waitFor(() => getByText(/Email/i));
  await waitFor(() => getByText(/Password/i));
  await waitFor(() => getByText(/Login/i));
});

test('renders registration form when register button clicked', async () => {
  const { getByText } = render(<App />);
  await waitFor(() => getByText(/Signup/i));
  fireEvent.click(getByText('Signup'));
  await waitFor(() => getByText(/Your name/i));
  await waitFor(() => getByText(/Your email/i));
  await waitFor(() => getByText(/Your password/i));
  await waitFor(() => getByText(/Create User/i));
});
