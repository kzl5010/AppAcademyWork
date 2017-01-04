import React, { Component } from 'react';

import GiphysIndex from './giphys_index';

class GiphysSearch extends Component {

  constructor() {
    super();
    this.state = { searchTerm: "" };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidMount() {
    this.props.fetchSearchGiphys("");
  }

  handleChange(e) {
    this.setState({
      searchTerm: e.currentTarget.value
    });
  }

  handleSubmit(e) {
    e.preventDefault();
    let term = this.state.searchTerm.split(" ").join(".");
    this.props.fetchSearchGiphys(term);
  }

  render() {
    let { giphys } = this.props;

    return (
      <div>

    )
  }
}
