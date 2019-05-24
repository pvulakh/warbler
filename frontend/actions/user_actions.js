import * as UserAPIUtil from '../util/user_api_util';
export const RECEIVE_USERS = 'RECEIVE_USERS';
export const RECEIVE_USER = 'RECEIVE_USER';

// export const receiveUsers = (payload) => {
//     return {
//         type: RECEIVE_USERS,
//         users: payload.users,
//         locations: payload.locations,
//     };
// };

export const receiveUsers = ({ users, locations }) => {
    return {
        type: RECEIVE_USERS,
        users,
        locations,
    };
};

export const receiveUser = (user) => {
    return {
        type: RECEIVE_USER,
        user,
    };
};

export const fetchUsers = () => {
    return (dispatch) => {
        return UserAPIUtil.fetchUsers().then(payload => {
            return dispatch(receiveUsers(payload));
        });
    };
};

export const fetchUser = (id) => {
    return (dispatch) => {
        return UserAPIUtil.fetchUser(id).then(user => {
            return dispatch(receiveUser(user));
        });
    };
};