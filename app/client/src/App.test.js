import React from 'react';
import { render } from '@testing-library/react';
import App from './App';

test.skip('renders header title "ToDo App"', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/ToDo App/i);
  expect(linkElement).toBeInTheDocument();
});

test('renders a header title', () => {
  const { container } = render(<App />);
  const header = container.querySelector('.header-main')
  expect(header).toHaveTextContent(/.+/);
});

test('check if app is rendered',()=>{
  const {container} = render(<App/>);
  const app = container.querySelector('.app-main');
  expect(app).toBeInTheDocument();
});
