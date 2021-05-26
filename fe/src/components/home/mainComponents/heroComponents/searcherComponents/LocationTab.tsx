import React, { useRef } from 'react';
import styled from 'styled-components';
import { useSearcherDispatch, useSearcherState } from '../../../../../hooks/SearcherHook';
import { LocationList, Location } from '../../../../../shared/interface';
import { mockupLocationData } from '../../../../../data/location';
import { useReservationDispatch } from '../../../../../hooks/ReservationHook';
import { Container, Tab, Layer } from './shared.style';

const LocationTab = (): React.ReactElement => {
    const reservationDispatch = useReservationDispatch();

    const searcherState = useSearcherState();
    const searcherDispatch = useSearcherDispatch();

    const inputRef = useRef<HTMLInputElement>(null);

    let debounceTimer: ReturnType<typeof setTimeout>;

    const { locationLayer, locationList } = searcherState;

    const handleInputLayer: React.MouseEventHandler<HTMLDivElement> = () => {
        searcherDispatch({ type: 'SHOW_LOCATION_LAYER', state: true });
        if (inputRef?.current) {
            inputRef.current.disabled = false;
            inputRef.current.focus();
        }
    };

    const handleInputLocationList = (event: React.ChangeEvent<HTMLInputElement>) => {
        if (debounceTimer) clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            if (!event.target.value) {
                searcherDispatch({ type: 'SHOW_LOCATION_LIST', list: [] });
                return;
            }
            const currLocationList: LocationList = mockupLocationData.location.filter((el) =>
                el.city.includes(event.target.value),
            );
            searcherDispatch({ type: 'SHOW_LOCATION_LIST', list: currLocationList });
        }, 200);
    };

    const setUpLocation = (place: Location) => {
        reservationDispatch({ type: 'LOCATION', id: place.id, city: place.city });
        searcherDispatch({ type: 'SHOW_INPUTOFLOCATION', value: place.city });
        if (inputRef?.current) {
            inputRef.current.value = place.city;
            inputRef.current.blur();
        }
        searcherDispatch({ type: 'SHOW_CHECKIN_CALENDAR_LAYER', state: true });
    };

    return (
        <Container>
            <Tab onClick={handleInputLayer}>
                <NavigatingText>위치</NavigatingText>
                <LocationInput
                    ref={inputRef}
                    onFocus={() => searcherDispatch({ type: 'SHOW_LOCATION_LAYER', state: true })}
                    onChange={handleInputLocationList}
                    disabled
                />
            </Tab>
            {locationLayer && (
                <Layer width={493} top={100} left={0} height={355}>
                    {locationList?.map((place: Location) => (
                        <li key={place.id} onClick={() => setUpLocation(place)}>
                            {place.city}
                        </li>
                    ))}
                </Layer>
            )}
        </Container>
    );
};

export default LocationTab;

const NavigatingText = styled.p`
    margin: 0;
`;

const LocationInput = styled.input`
    margin: 0;
`;