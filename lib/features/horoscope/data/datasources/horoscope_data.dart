import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';

class HoroscopeData {
  final DateTime start;
  final DateTime end;
  final Horoscope horoscope;

 const HoroscopeData({
    required this.start,
    required this.end,
    required this.horoscope,
  });
}

final List<HoroscopeData> LIST_HOROSCOPE_DATA = [
  HoroscopeData(
    start: DateTime(2023, 01, 22),
    end: DateTime(2024, 02, 09),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(2022, 02, 01),
    end: DateTime(2023, 01, 21),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(2021, 02, 12),
    end: DateTime(2022, 01, 31),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(2020, 01, 25),
    end: DateTime(2021, 02, 11),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(2019, 02, 05),
    end: DateTime(2020, 01, 24),
    horoscope: Horoscope.pig,
  ),
  HoroscopeData(
    start: DateTime(2018, 02, 16),
    end: DateTime(2019, 02, 04),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(2017, 01, 28),
    end: DateTime(2018, 02, 15),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(2016, 02, 08),
    end: DateTime(2017, 01, 27),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(2015, 02, 19),
    end: DateTime(2016, 02, 07),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(2014, 01, 31),
    end: DateTime(2015, 02, 18),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(2013, 02, 10),
    end: DateTime(2014, 01, 30),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(2012, 01, 23),
    end: DateTime(2013, 02, 09),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(2011, 02, 03),
    end: DateTime(2012, 01, 22),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(2010, 02, 14),
    end: DateTime(2011, 02, 02),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(2009, 01, 26),
    end: DateTime(2010, 02, 13),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(2008, 02, 07),
    end: DateTime(2009, 01, 25),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(2007, 02, 18),
    end: DateTime(2008, 02, 06),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(2006, 01, 29),
    end: DateTime(2007, 02, 17),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(2005, 02, 09),
    end: DateTime(2006, 01, 28),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(2004, 01, 22),
    end: DateTime(2005, 02, 08),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(2003, 02, 01),
    end: DateTime(2004, 01, 21),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(2002, 02, 12),
    end: DateTime(2003, 01, 31),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(2001, 01, 24),
    end: DateTime(2002, 02, 11),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(2000, 02, 05),
    end: DateTime(2001, 01, 23),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1999, 02, 16),
    end: DateTime(2000, 02, 04),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1998, 01, 28),
    end: DateTime(1999, 02, 15),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1997, 02, 07),
    end: DateTime(1998, 01, 27),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1996, 02, 19),
    end: DateTime(1997, 02, 06),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1995, 01, 31),
    end: DateTime(1996, 02, 18),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1994, 02, 10),
    end: DateTime(1995, 01, 30),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1993, 01, 23),
    end: DateTime(1994, 02, 09),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1992, 02, 04),
    end: DateTime(1993, 01, 22),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1991, 02, 15),
    end: DateTime(1992, 02, 03),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1990, 01, 27),
    end: DateTime(1991, 02, 14),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1989, 02, 06),
    end: DateTime(1990, 01, 26),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1988, 02, 17),
    end: DateTime(1989, 02, 05),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1987, 01, 29),
    end: DateTime(1988, 02, 16),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1986, 02, 09),
    end: DateTime(1987, 01, 28),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1985, 02, 20),
    end: DateTime(1986, 02, 08),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1984, 02, 02),
    end: DateTime(1985, 02, 19),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1983, 02, 13),
    end: DateTime(1984, 02, 01),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1982, 01, 25),
    end: DateTime(1983, 02, 12),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1981, 02, 05),
    end: DateTime(1982, 01, 24),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1980, 02, 16),
    end: DateTime(1981, 02, 04),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1979, 01, 28),
    end: DateTime(1980, 02, 15),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1978, 02, 07),
    end: DateTime(1979, 01, 27),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1977, 02, 18),
    end: DateTime(1978, 02, 06),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1976, 01, 31),
    end: DateTime(1977, 02, 17),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1975, 02, 11),
    end: DateTime(1976, 01, 30),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1974, 01, 23),
    end: DateTime(1975, 02, 10),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1973, 02, 03),
    end: DateTime(1974, 01, 22),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1972, 01, 16),
    end: DateTime(1973, 02, 02),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1971, 01, 27),
    end: DateTime(1972, 01, 15),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1970, 02, 06),
    end: DateTime(1971, 01, 26),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1969, 02, 17),
    end: DateTime(1970, 02, 05),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1968, 01, 30),
    end: DateTime(1969, 02, 16),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1967, 02, 09),
    end: DateTime(1968, 01, 29),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1966, 01, 21),
    end: DateTime(1967, 02, 08),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1965, 02, 02),
    end: DateTime(1966, 01, 20),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1964, 02, 13),
    end: DateTime(1965, 02, 01),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1963, 01, 25),
    end: DateTime(1964, 02, 12),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1962, 02, 05),
    end: DateTime(1963, 01, 24),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1961, 02, 15),
    end: DateTime(1962, 02, 04),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1960, 01, 28),
    end: DateTime(1961, 02, 14),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1959, 02, 08),
    end: DateTime(1960, 01, 27),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1958, 02, 18),
    end: DateTime(1959, 02, 07),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1957, 01, 31),
    end: DateTime(1958, 02, 17),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1956, 02, 12),
    end: DateTime(1957, 01, 30),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1955, 01, 24),
    end: DateTime(1956, 02, 11),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1954, 02, 03),
    end: DateTime(1955, 01, 23),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1953, 02, 14),
    end: DateTime(1954, 02, 02),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1952, 01, 27),
    end: DateTime(1953, 02, 13),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1951, 02, 06),
    end: DateTime(1952, 01, 26),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1950, 02, 17),
    end: DateTime(1951, 02, 05),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1949, 01, 29),
    end: DateTime(1950, 02, 16),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1948, 02, 10),
    end: DateTime(1949, 01, 28),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1947, 01, 22),
    end: DateTime(1948, 02, 09),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1946, 02, 02),
    end: DateTime(1947, 01, 21),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1945, 02, 13),
    end: DateTime(1946, 02, 01),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1944, 01, 25),
    end: DateTime(1945, 02, 12),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1943, 02, 05),
    end: DateTime(1944, 01, 24),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1942, 02, 15),
    end: DateTime(1943, 02, 04),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1941, 01, 27),
    end: DateTime(1942, 02, 14),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1940, 02, 08),
    end: DateTime(1941, 01, 26),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1939, 02, 19),
    end: DateTime(1940, 02, 07),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1938, 01, 31),
    end: DateTime(1939, 02, 18),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1937, 02, 11),
    end: DateTime(1938, 01, 30),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1936, 01, 24),
    end: DateTime(1937, 02, 10),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1935, 02, 04),
    end: DateTime(1936, 01, 23),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1934, 02, 14),
    end: DateTime(1935, 02, 03),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1933, 01, 26),
    end: DateTime(1934, 02, 13),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1932, 02, 06),
    end: DateTime(1933, 01, 25),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1931, 02, 17),
    end: DateTime(1932, 02, 05),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1930, 01, 30),
    end: DateTime(1931, 02, 16),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1929, 02, 10),
    end: DateTime(1930, 01, 29),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1928, 01, 23),
    end: DateTime(1929, 02, 09),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1927, 02, 02),
    end: DateTime(1928, 01, 22),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1926, 02, 13),
    end: DateTime(1927, 02, 01),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1925, 01, 25),
    end: DateTime(1926, 02, 12),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1924, 02, 05),
    end: DateTime(1925, 01, 24),
    horoscope: Horoscope.rat,
  ),
  HoroscopeData(
    start: DateTime(1923, 02, 16),
    end: DateTime(1924, 02, 04),
    horoscope: Horoscope.boar,
  ),
  HoroscopeData(
    start: DateTime(1922, 01, 28),
    end: DateTime(1923, 02, 15),
    horoscope: Horoscope.dog,
  ),
  HoroscopeData(
    start: DateTime(1921, 02, 08),
    end: DateTime(1922, 01, 27),
    horoscope: Horoscope.rooster,
  ),
  HoroscopeData(
    start: DateTime(1920, 02, 20),
    end: DateTime(1921, 02, 07),
    horoscope: Horoscope.monkey,
  ),
  HoroscopeData(
    start: DateTime(1919, 02, 01),
    end: DateTime(1920, 02, 19),
    horoscope: Horoscope.goat,
  ),
  HoroscopeData(
    start: DateTime(1918, 02, 11),
    end: DateTime(1919, 01, 31),
    horoscope: Horoscope.horse,
  ),
  HoroscopeData(
    start: DateTime(1917, 01, 23),
    end: DateTime(1918, 02, 10),
    horoscope: Horoscope.snake,
  ),
  HoroscopeData(
    start: DateTime(1916, 02, 03),
    end: DateTime(1917, 01, 22),
    horoscope: Horoscope.dragon,
  ),
  HoroscopeData(
    start: DateTime(1915, 02, 14),
    end: DateTime(1916, 02, 02),
    horoscope: Horoscope.rabbit,
  ),
  HoroscopeData(
    start: DateTime(1914, 01, 26),
    end: DateTime(1915, 02, 13),
    horoscope: Horoscope.tiger,
  ),
  HoroscopeData(
    start: DateTime(1913, 02, 06),
    end: DateTime(1914, 01, 25),
    horoscope: Horoscope.ox,
  ),
  HoroscopeData(
    start: DateTime(1912, 02, 18),
    end: DateTime(1913, 02, 05),
    horoscope: Horoscope.rat,
  ),
];
