import { RECEIVE_USERS } from '../../actions/user_actions';

const locationsReducer = (state = {}, action) => {
  const { locations } = action;
  // ^ this is destructoring the action object and setting a
  // constant of locations to be the action.locations that comes in.
  const oldState = Object.freeze(state);
  switch (action.type) {
    case RECEIVE_USERS:
      return Object.assign({}, oldState, locations);
    default: 
      return state;
  }
};

export default locationsReducer;