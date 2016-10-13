echo 'React Up  v-0.0.1
------------------'
npm init

echo '
Installing react + redux
'
npm install react react-dom redux redux-thunk react-redux --save

echo '
Installing react-router
'
npm install react-router --save

echo '
Installing tachyons
'
npm install tachyons --save

echo '
Installing webpack
'
npm install webpack webpack-dashboard webpack-dev-server --save-dev

echo '
Installing eslint
'
npm install eslint eslint-plugin-babel eslint-plugin-react --save-dev

echo '
Installing babel
'
npm install babel-cli babel-preset-es2015 babel-preset-react babel-eslint babel-loader babel-plugin-add-module-exports babel-preset-stage-0 babel-preset-react-hmre --save-dev

echo '
Setting up webpack
';
cp ../react-up/webpack.* .

echo '
Setting up eslint
'
cp ../react-up/.eslintrc .

echo '
Setting up public directory
'
mkdir public
cd public

echo '
Creating index.html
'
touch index.html

echo '
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>React Up</title>
  </head>
  <style>
    @font-face { font-family: Lato, "sans-serif"; }
    .spinner {
      margin: auto;
      position: absolute;
      top: 0; left: 0; bottom: 0; right: 0;
    }
  </style>
  <body>
    <div id="container" class="">
      <img class="spinner" src="/assets/spinner.gif" alt="Loading ...">
    </div>
  </body>
  <script src="/app.built.js"></script>
</html>

' >> index.html

cd ..

echo '
Setting up src directory
'
mkdir src
cd src

echo '
Creating routes.js
'
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

render(<Routes/>, document.getElementById('container'));

" >> routes.js

echo '
Setting up reducers directory
'
mkdir reducers
cd reducers 

echo '
Creating rootReducer
'
touch index.js
echo "import {combineReducers} from 'redux';
import auth from '~/reducers/auth';

const rootReducer = combineReducers({
  auth
});

export default rootReducer;

" >> index.js

echo '
Creating auth reducer
'
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

echo '
Setting up containers directory
'
mkdir containers
cd containers
touch App.js
touch Landing.js

echo '
Creating container App.js
'

echo "import React, {Component, PropTypes} from 'react';
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

class App extends Component {
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

echo '
Creating container Landing.js
'

echo "import React, {Component, PropTypes} from 'react';

class Landing extends Component {
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

echo '
Setting up assets directory
'
cd ../../
mkdir public/assets

echo '
Copying spinner.gif
'
cp ../react-up/spinner.gif public/assets/

echo '
Setup Complete
--------------
'
echo 'Copy paste the following in package.json

"scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "clean": "rm public/app.built.js",
    "build": "webpack --define --config webpack.dev.js --progress",
    "build-production": "webpack --define process.env.NODE_ENV=`\"production\"` --config webpack.prod.js --progress",
    "start": "webpack-dashboard -t frontend -- webpack-dev-server ./src/routes.js --config webpack.dev.js --progress --port 5000 --inline --hot"
  },

'
