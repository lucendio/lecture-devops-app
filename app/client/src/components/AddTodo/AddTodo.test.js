import React from 'react';
import { render, waitFor, fireEvent } from '@testing-library/react';
import AddTodo from './AddTodo';
import WelcomeHeader from '../WelcomeHeader/WelcomeHeader';
import * as api from '../../utils/APICalls';

jest.mock("../WelcomeHeader/WelcomeHeader", () => jest.fn(() => null));

afterEach(() => {
    jest.clearAllMocks();
})

test('initialization', async () => {
    let signoutFunc = jest.fn();
    const { getByText, getByLabelText } = render(<AddTodo
        userName={ "Jane Doe" }
        signout={ signoutFunc }
    />);

    // Welcome Header called correctly
    expect(WelcomeHeader).toHaveBeenCalledWith({userName: "Jane Doe", signout: signoutFunc}, expect.anything());

    // All elements present
    await waitFor(() => getByText(/Title/i));
    await waitFor(() => getByText(/Description/i));
    await waitFor(() => getByText(/Reset/i));
    await waitFor(() => getByText(/Add/i));
});

test('api interaction', async () => {
    let addTodo = jest.fn();
    const { getByText, getByLabelText } = render(<AddTodo
        addTodo={ addTodo }
    />);

    // try adding a todo without a title
    fireEvent.click(getByText(/add/i));
    await waitFor(() => getByText(/title cannot be blank/i));

    // set a title and description and try again
    fireEvent.change(getByLabelText(/Title/i), { target: { value: "foo" } });
    fireEvent.change(getByLabelText(/Description/i), { target: { value: "bar" } });

    // mock api
    let apiMock = jest.spyOn(api, 'addTodo')
    apiMock.mockRejectedValueOnce({data: {message: "mocked api error"}});

    // try adding the todo but the api will fail
    fireEvent.click(getByText(/add/i));
    expect(apiMock).toHaveBeenCalledWith("foo", "bar");
    expect(addTodo).not.toHaveBeenCalled();
    apiMock.mockClear();

    // now let it succeed
    apiMock.mockResolvedValueOnce({
        "todo": {
            "important": false,
            "done": false,
            "_id": "thisIsSomeRandomID",
            "title": "foo",
            "description": "bar",
            "user": "thisIsSomeRandomUserID",
            "createdAt": "2021-08-15T17:01:19.264Z",
            "updatedAt": "2021-08-15T17:01:19.264Z",
            "__v": 0
        }
    });

    fireEvent.click(getByText(/add/i));
    expect(apiMock).toHaveBeenCalled();
    await waitFor(() => expect(addTodo).toHaveBeenCalledWith({
        title: "foo",
        description: "bar",
        important: false,
        done: false,
        _id: "thisIsSomeRandomID"
    }));

    apiMock.mockRestore();
});
