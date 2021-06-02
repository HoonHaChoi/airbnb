import React, { useReducer, useState } from 'react';
import styled from 'styled-components';
import { ReservationDispatchContext, ReservationStateContext } from 'Contexts';
import { ReservationContext } from 'shared/interface';
import reservationReducer from 'shared/reservationReducer';
import Header from 'components/header/Header';
import Searcher from 'components/searcher/Searcher';

const initialState = {
    location: {
        id: 0,
        address: '',
        latitude: null,
        logitude: null,
    },
    checkIn: {
        year: 0,
        month: 0,
        day: 0,
    },
    checkOut: {
        year: 0,
        month: 0,
        day: 0,
    },
    fee: [0, 100],
    people: {
        adult: 0,
        children: 0,
        kids: 0,
    },
} as ReservationContext;

const Hero = (): React.ReactElement => {
    const [reservationState, reservationDispatch] = useReducer(reservationReducer, initialState);
    const [fullState, setFullState] = useState(true);

    return (
        <ReservationDispatchContext.Provider value={reservationDispatch}>
            <ReservationStateContext.Provider value={reservationState}>
                <HeroSection>
                    <Header isFull={fullState} setFullState={setFullState} />
                    <Searcher />
                </HeroSection>
            </ReservationStateContext.Provider>
        </ReservationDispatchContext.Provider>
    );
};

export default Hero;

const HeroSection = styled.section`
    height: 640px;
    background: #ddd;
`;