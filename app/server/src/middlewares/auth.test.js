const auth = require('../middlewares/auth');
const jwt = require('jsonwebtoken');
const { model: Users } = require('../models/Users');

describe('Testing the authorization middleware', () => {
    let mockRequest;
    let mockResponse;
    let nextFunction = jest.fn();

    const token = 'mytoken';

    beforeEach(() => {
        mockRequest = {
            cookies: {
                'todo-jt': token,
            }
        };
        mockResponse = {
            redirect: jest.fn(),
            status: jest.fn(() => {
                return {
                    send: jest.fn()
                }
            })
        };
    });

    test('should redirect, if the value of the todo-jt cookie is an empty string', async () => {
        mockRequest.cookies['todo-jt'] = '';
        auth(mockRequest, mockResponse, nextFunction);

        expect(mockResponse.redirect).toHaveBeenCalledWith(401, '/login');
    });

    test('should save the found user and token in the request', async () => {
        const mockUser = {
            username: 'testname',
            password: 'testpw'
        };

        jest.spyOn(jwt, 'verify').mockReturnValue(token);
        jest.spyOn(Users, 'findOne').mockResolvedValue(mockUser);

        await auth(mockRequest, mockResponse, nextFunction);

        expect(mockRequest.token).toEqual(token)
        expect(mockRequest.user).toEqual(mockUser);
    });

    test('should sent a 401 status code, if the user could not be found', async () => {
        jest.spyOn(jwt, 'verify').mockReturnValue(token);
        jest.spyOn(Users, 'findOne').mockResolvedValue(undefined);

        await auth(mockRequest, mockResponse, nextFunction);

        expect(mockRequest.user).toBeUndefined;
        expect(mockResponse.status).toHaveBeenCalledWith(401);
    });
});
