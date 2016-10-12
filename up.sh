# npm init

# npm install react react-dom redux redux-thunk react-redux --save
# npm install react-router --save
# npm install tachyons --save
# npm install webpack webpack-dashboard webpack-dev-server --save-dev
# npm install eslint eslint-plugin-babel eslint-plugin-react --save-dev
# npm install babel-cli babel-preset-es2015 babel-preset-react babel-eslint babel-loader babel-plugin-add-module-exports babel-preset-stage-0 babel-preset-react-hmre --save-dev

# cp ../react-up/webpack.* .
# cp ../react-up/.eslintrc .
# mkdir public
# cd public
# touch index.html

# echo '
# <!DOCTYPE html>
# <html>
#   <head>
#     <meta charset="utf-8">
#     <title>React Up</title>
#   </head>
#   <style>
#     @font-face { font-family: Lato, "sans-serif"; }
#     .spinner {
#       margin: auto;
#       position: absolute;
#       top: 0; left: 0; bottom: 0; right: 0;
#     }
#   </style>
#   <body>
#     <div id="container" class="">
#       <img class="spinner" src="/assets/spinner.gif" alt="Loading ...">
#     </div>
#   </body>
#   <script src="/app.built.js"></script>
# </html>

# ' >> index.html

# cd ..
mkdir src
cd src
touch routes.js

echo "import React from 'react';
import {render} from 'react-dom';
import {Router, Route, browserHistory, IndexRoute} from 'react-router';

import App from '~/containers/App';
import Landing from '~/containers/Landing';

const Routes = () => (
  <Router history={browserHistory}>
    <Route path='/' component={App}>
      <IndexRoute component={Landing} />
    </Route>
  </Router>
);

export function serve() {
  render(<Routes/>, document.getElementById('container'));
}

" >> routes.js

mkdir reducers
cd reducers 
touch index.js
echo "import {combineReducers} from 'redux';
import auth from '~/reducers/auth';

const rootReducer = combineReducers({
  auth
});

export default rootReducer;

" >> index.js

touch auth.js
echo "export default function auth(state={}, action) {
  switch (action.type) {
    case 'auth.logInError':
      return {...state, logInErrors: action.payload.errors};

    case 'auth.logInSuccess':
      return {...state, isUserLoggedIn: true};

    case 'auth.dataLoaded':
      return {...state, token: action.payload.token, isUserLoggedIn: action.payload.token !== null};

    case 'auth.logOut':
      return {...state, isUserLoggedIn: false};

    case 'auth.signUpError':
      return {...state, signUpErrors: action.payload.errors};
  }
  return state;
}

" >> auth.js
cd ..


mkdir containers
cd containers
touch App.js
touch Landing.js

echo "import React, {PropTypes} from 'react';
import {createStore, applyMiddleware, compose} from 'redux';
import thunk from 'redux-thunk';
import {Provider} from 'react-redux';

import rootReducer from '~/reducers';

const store = createStore(
  rootReducer,
  compose(
    applyMiddleware(thunk),
    window.devToolsExtension ? window.devToolsExtension() : f => f
  )
);

class App extends React.Component {
  render() {
    return <div className='App'>
      <Provider store={store}>
          <div style={{height: '100%'}}>
            {this.props.children}
          </div>
      </Provider>
    </div>;
  }
}

App.propTypes = {
  children: PropTypes.object
};

export default App;
" >> App.js

echo "import React, {PropTypes} from 'react';

class Landing extends React.Component {
  render() {
    return <div>
      You have landed, Sir.
    </div>;
  }
}

Landing.propTypes = {
  children: PropTypes.object
};

export default Landing;
" >> Landing.js

cd ../../
mkdir public/assets
cp ../react-up/spinner.gif public/assets/
# echo 'Copy paste the following in package.json

# "scripts": {
#     "test": "echo \"Error: no test specified\" && exit 1",
#     "clean": "rm public/app.built.js",
#     "build": "webpack --define --config webpack.dev.js --progress",
#     "build-production": "webpack --define process.env.NODE_ENV=`\"production\"` --config webpack.prod.js --progress",
#     "start": "webpack-dashboard -t frontend -- webpack-dev-server ./app/routes.js --config webpack.dev.js --progress --port 5000 --inline --hot"
#   }

# '
