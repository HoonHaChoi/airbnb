import './App.css';
import React from 'react';
import Router from './Router';
import { ThemeProvider } from 'styled-components';
import { theme } from './styles/theme';
import GlobalStyle from './styles/GlobalStyle';

function App(): React.ReactElement {
    return (
        <ThemeProvider theme={theme}>
            <GlobalStyle />
            <Router />
        </ThemeProvider>
    );
}

export default App;