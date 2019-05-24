import {
  RECEIVE_WARBLE,
  REMOVE_WARBLE,
  RECEIVE_WARBLES,
} from '../../actions/warble_actions';

export default (state = {}, action) => {
  // debugger
  const oldState = Object.freeze(state);
  const { warble } = action;

  // debugger
  switch (action.type) {
    case RECEIVE_WARBLE:
      // Object.assign returns a new object with the oldState as a blueprint; we then merge the new warble obj
      // Object.assign returns a shallow dup - lodash merge is a deep recursive dup

      // debugger
      return Object.assign({}, oldState, { [warble.id]: warble });
    case RECEIVE_WARBLES:
      // debugger;
      const newWarbles = {};
      action.warbles.forEach(warble => {
        newWarbles[warble.id] = warble;
      });
      return Object.assign({}, oldState, newWarbles);
    case REMOVE_WARBLE:
      const newState = Object.assign({}, oldState);
      delete newState[action.id];
      return newState;
    default:
      return state;
  }
};