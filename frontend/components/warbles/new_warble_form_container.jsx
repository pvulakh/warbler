import { connect } from 'react-redux';
import {
  createWarble
} from '../../actions/warble_actions';
import WarbleForm from './warble_form';

const msp = (state) => {
  return {
    body: '',
    inputLabel: 'New Warble',
  };
};

const mdp = (dispatch) => {
  return {
    warbleAction: warble => dispatch(createWarble(warble)),
  };
};

export default connect(msp, mdp)(WarbleForm);