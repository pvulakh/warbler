import { combineReducers } from 'redux';
import entities from './entities/entities_reducer';

// the root reducer has a key of entities where it's going to hold 
// all of our data. We will/can also have other top level slices 
// like ui, errors, etc.
export default combineReducers({
  entities,
});