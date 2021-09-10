import React from 'react';
import { render, getByText } from '@testing-library/react';
import Signup from './Signup';

describe('<Signup /> component', () => {
    it('renders a Signup contents', () => {
        const { container, getByText } = render(<Signup />);
        const main_container = container.querySelector('.login-todo-main')
        expect(main_container).toBeVisible();

        expect(main_container).toHaveTextContent('Your name');
        expect(main_container).toHaveTextContent('Your email');
        expect(main_container).toHaveTextContent('Your password');

        const button_create = getByText('Create User');
        expect(button_create).toBeVisible();

        const button_singin = getByText('Sign-in');
        expect(button_singin).toBeVisible();
    });
});
