import { Dispatch } from 'react';

export interface UsefulObject {
    [key: string]: string;
}

export interface Location {
    id: number;
    latitude: number | null;
    logitude: number | null;
    address: string;
}

export interface Date {
    year: number;
    month: number;
    day: number;
}

export interface People {
    guest: number;
    kids: number;
}

export interface PeopleCount {
    adult: number;
    children: number;
    kids: number;
}

export interface ReservationContext {
    location: Location;
    checkIn: Date;
    checkOut: Date;
    fee: number[];
    people: PeopleCount;
}

export type ReservationAction =
    | { type: 'LOCATION'; id: number; latitude: number | null; logitude: number | null; address: string }
    | { type: 'CHECKIN'; year: number; month: number; day: number }
    | { type: 'CHECKOUT'; year: number; month: number; day: number }
    | { type: 'PEOPLE'; adult: number; children: number; kids: number }
    | { type: 'FEE'; fee: number[] }
    | { type: 'RESET_DATE' };

export interface SearchContext {
    locationLayer: boolean;
    checkInCalendarLayer: boolean;
    checkOutCalendarLayer: boolean;
    feeLayer: boolean;
    peopleLayer: boolean;
}

export interface SearcherContext extends SearchContext {
    locationList: Location[] | null;
    inputOfLocation: string | null;
}

export type SearchAction =
    | { type: 'SHOW_LOCATION_LIST'; list: Location[] | null }
    | { type: 'SHOW_LOCATION_LAYER'; state: boolean }
    | { type: 'SHOW_INPUTOFLOCATION'; value: string }
    | { type: 'SHOW_CHECKIN_CALENDAR_LAYER'; state: boolean }
    | { type: 'SHOW_CHECKOUT_CALENDAR_LAYER'; state: boolean }
    | { type: 'SHOW_FEE_LAYER'; state: boolean }
    | { type: 'SHOW_PEOPLE_LAYER'; state: boolean }
    | { type: 'CLOSE_ALL' };

export type SearcherLayerStateAction =
    | { type: 'SELECT_LOCATION_TAB' }
    | { type: 'SELECT_CHECKIN_TAB' }
    | { type: 'SELECT_CHECKOUT_TAB' }
    | { type: 'SELECT_FEE_TAB' }
    | { type: 'SELECT_PEOPLE_TAB' };

export type ReservationDispatch = Dispatch<ReservationAction>;

export type SearchDispatch = Dispatch<SearchAction>;

export type SearchLayerDispatch = Dispatch<SearcherLayerStateAction>;

export type LocationList = Location[];

export type Td = {
    classNames: string[] | null;
    dataSets: string[] | null;
    countDay: number;
};

export type CalendarType = {
    isCheckIn: boolean;
};

export type DateType = {
    possible: boolean;
    typeOfDate: string;
};

export type LayerSpecType = {
    width: number;
    top: number;
    left: number;
    height: number;
};

export type ModalLayerType = {
    children: React.ReactNode;
    options: LayerSpecType;
};

export interface AccomodationType {
    latitude: number;
    longitude: number;
    address_id: number;
    theme_id: number;
    name: string;
    rental_fee_per_night: number;
    person_capacity: number;
    bedrooms: number;
    beds: number;
    bathrooms: number;
    avg_rating: number;
    room_and_property_type: string;
    images_fe: {
        thumbnail: string;
    };
    amenities: string[];
}