import React, { useRef } from 'react';
import styled from 'styled-components';
import { useSearcherDispatch, useSearcherState } from 'hooks/SearcherHook';
import { LocationList, Location } from 'shared/interface';
import { mockupLocationData } from 'data/location';
import { useReservationDispatch } from 'hooks/ReservationHook';
import { Container, Tab, NavigatingText, ResultText } from './common/shared.style';
import ModalLayer from './common/ModalLayer';
import { theme } from 'styles/theme';

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

            // fetch(`http://airbnb.clone.r-e.kr/api/search/${event.target.value}`)
            //     .then((res) => res.json())
            //     .then((res) => {
            //         console.log(res);
            //         const currLocationList = res.location_list;
            //         searcherDispatch({ type: 'SHOW_LOCATION_LIST', list: currLocationList });
            //     });
            const currLocationList: LocationList = mockupLocationData.location_list.filter((el) =>
                el.address.includes(event.target.value),
            );
            searcherDispatch({ type: 'SHOW_LOCATION_LIST', list: currLocationList });
        }, 200);
    };

    const setUpLocation = (place: Location) => {
        const { id, logitude, latitude, address } = place;
        reservationDispatch({ type: 'LOCATION', id, logitude, latitude, address });
        searcherDispatch({ type: 'SHOW_INPUTOFLOCATION', value: place.address });
        if (inputRef?.current) {
            inputRef.current.value = place.address;
            inputRef.current.blur();
        }
        searcherDispatch({ type: 'SHOW_CHECKIN_CALENDAR_LAYER', state: true });
    };

    return (
        <Container>
            <Tab onClick={handleInputLayer}>
                <NavigatingText>위치</NavigatingText>
                <ResultText>
                    <LocationInput
                        ref={inputRef}
                        onFocus={() => searcherDispatch({ type: 'SHOW_LOCATION_LAYER', state: true })}
                        onChange={handleInputLocationList}
                        disabled
                    />
                </ResultText>
            </Tab>
            {locationLayer && (
                <ModalLayer
                    options={{
                        width: theme.LayerSize.mdWidth,
                        top: theme.LayerLocation.top,
                        left: 0,
                        height: theme.LayerSize.mdHeight,
                    }}
                >
                    <LocationResultListAll>
                        {locationList?.map((place: Location) => (
                            <ResultList key={place.id} onClick={() => setUpLocation(place)}>
                                {place.address}
                            </ResultList>
                        ))}
                    </LocationResultListAll>
                </ModalLayer>
            )}
        </Container>
    );
};

export default LocationTab;

const LocationInput = styled.input`
    margin: 0;
`;

const LocationResultListAll = styled.ul`
    margin: 60px;
`;

const ResultList = styled.li`
    margin-bottom: 10px;
`;