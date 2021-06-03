package com.codesquad21.team07.airbnb.repository;

import com.codesquad21.team07.airbnb.domain.Location;
import com.codesquad21.team07.airbnb.dtoGroup.response.LocationDTO;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.codesquad21.team07.airbnb.repository.sql.LocationQueriesKt.FIND_ADDRESS_BY_KEYWORD;


@Repository
public class LocationRepository implements MyRepository<Location>{

    private NamedParameterJdbcTemplate jdbc;
    private RowMapper<Location> rowMapper = BeanPropertyRowMapper.newInstance(Location.class);

    public LocationRepository(DataSource dataSource) {
        jdbc = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<LocationDTO> findByAddress(String address) {
        Map<String, String> parameter = Collections.singletonMap("input",address);

        // 지금 Location 도메인 클래스에 setter가 있는데 나중에 없애기
        List<Location> location = jdbc.query(FIND_ADDRESS_BY_KEYWORD, parameter, rowMapper);

        return location.stream().map(LocationDTO::of).collect(Collectors.toList());
    }


    @Override
    public List<Location> findAll() {
        return null;
    }

    @Override
    public void save() {

    }

    @Override
    public Optional<Location> findRoomById(Long id) {
        return Optional.empty();
    }

    @Override
    public void update(Location location, Long id) {

    }

    @Override
    public void delete(Long id) {

    }
}
