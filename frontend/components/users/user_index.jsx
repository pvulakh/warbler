import React from "react";
import { connect } from 'react-redux';
import { fetchUsers } from '../../actions/user_actions';
import UserShow from './user_show';

class UserIndex extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            selectedWarbler: null,
        };
    }

    componentDidMount() {
        this.props.fetchUsers();
    }

    selectWarbler(id) {
        return () => {
            this.setState({ selectedWarbler: id });
        };
    }

    render() {
        const { users } = this.props;
        const userLis = Object.values(users).map(user => {
            return (
                <li key={user.id} 
                    className="user-index-item" 
                    onClick={this.selectWarbler(user.id)}
                >
                    <p>{user.name}</p>
                </li>
            );
        });

        const { selectedWarbler } = this.state;
        return (
            <main className="user-index">
                <div>
                    <h3>Meet the Warblers!</h3>
                    <ul className="user-list">
                        {userLis}
                    </ul>
                </div>
                {selectedWarbler ?
                    <UserShow
                        warblerId={selectedWarbler}
                        closeShow={() => this.setState({ selectedWarbler: null })}
                    /> : null}
            </main>
        );
    }
}

const mapStateToProps = state => {
    const users = state.entities.users;
    return {
        users
    };
};

const mapDispatchToProps = dispatch => {
    return {
        fetchUsers: () => dispatch(fetchUsers())
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(UserIndex);