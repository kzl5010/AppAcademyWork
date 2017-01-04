import * as APIUtil from '../util/api_util';

export const RECEIVE_SEARCH_GIFS = 'RECEIVE_SG';
export const REQUEST_SEARCH_GIFS = 'REQUEST_SG';

export const fetchSearchGiphys = (term) => (
  (dispatch) => {
    APIUtil.fetchSearchGiphys(term).then(gifs => dispatch(receiveSearchGiphys(gifs.data)));
  }
);

export const receiveSearchGiphys = gifs => ({
  type: RECEIVE_SEARCH_GIFS,
  gifs
});
