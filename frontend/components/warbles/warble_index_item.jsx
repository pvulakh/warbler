import React from 'react';
import { connect } from 'react-redux';
import {
  removeWarble,
} from '../../actions/warble_actions';

const WarbleItem = ({ warble, author, deleteWarble }) => {
  return (
    <li>
      <strong>{author.name}</strong>: {warble.body}
      <br />
      <button type="button" onClick={() => deleteWarble(warble.id)}>
        Delete Warble
      </button>
    </li>
  );
};

const msp = (state, ownProps) => {
  const defaultAuthor = { name: 'Anonymous' };
  const author = state.entities.users[ownProps.warble.author_id] || defaultAuthor;
  return {
    author: author,
  };
};

const mdp = (dispatch) => {
  return {
    deleteWarble: id => dispatch(removeWarble(id)),
  }
}

export default connect(msp, mdp)(WarbleItem);
