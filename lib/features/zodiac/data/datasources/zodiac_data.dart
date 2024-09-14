import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';

class ZodiacData {
  final DateTime start;
  final DateTime end;
  final Zodiac zodiac;

  const ZodiacData({
    required this.start,
    required this.end,
    required this.zodiac,
  });
}

final List<ZodiacData> LIST_ZODIAC_DATA = [
  ZodiacData(
    start: DateTime(2023, 01, 22),
    end: DateTime(2024, 02, 09),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(2022, 02, 01),
    end: DateTime(2023, 01, 21),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(2021, 02, 12),
    end: DateTime(2022, 01, 31),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(2020, 01, 25),
    end: DateTime(2021, 02, 11),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(2019, 02, 05),
    end: DateTime(2020, 01, 24),
    zodiac: Zodiac.pig,
  ),
  ZodiacData(
    start: DateTime(2018, 02, 16),
    end: DateTime(2019, 02, 04),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(2017, 01, 28),
    end: DateTime(2018, 02, 15),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(2016, 02, 08),
    end: DateTime(2017, 01, 27),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(2015, 02, 19),
    end: DateTime(2016, 02, 07),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(2014, 01, 31),
    end: DateTime(2015, 02, 18),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(2013, 02, 10),
    end: DateTime(2014, 01, 30),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(2012, 01, 23),
    end: DateTime(2013, 02, 09),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(2011, 02, 03),
    end: DateTime(2012, 01, 22),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(2010, 02, 14),
    end: DateTime(2011, 02, 02),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(2009, 01, 26),
    end: DateTime(2010, 02, 13),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(2008, 02, 07),
    end: DateTime(2009, 01, 25),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(2007, 02, 18),
    end: DateTime(2008, 02, 06),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(2006, 01, 29),
    end: DateTime(2007, 02, 17),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(2005, 02, 09),
    end: DateTime(2006, 01, 28),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(2004, 01, 22),
    end: DateTime(2005, 02, 08),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(2003, 02, 01),
    end: DateTime(2004, 01, 21),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(2002, 02, 12),
    end: DateTime(2003, 01, 31),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(2001, 01, 24),
    end: DateTime(2002, 02, 11),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(2000, 02, 05),
    end: DateTime(2001, 01, 23),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1999, 02, 16),
    end: DateTime(2000, 02, 04),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1998, 01, 28),
    end: DateTime(1999, 02, 15),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1997, 02, 07),
    end: DateTime(1998, 01, 27),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1996, 02, 19),
    end: DateTime(1997, 02, 06),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1995, 01, 31),
    end: DateTime(1996, 02, 18),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1994, 02, 10),
    end: DateTime(1995, 01, 30),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1993, 01, 23),
    end: DateTime(1994, 02, 09),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1992, 02, 04),
    end: DateTime(1993, 01, 22),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1991, 02, 15),
    end: DateTime(1992, 02, 03),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1990, 01, 27),
    end: DateTime(1991, 02, 14),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1989, 02, 06),
    end: DateTime(1990, 01, 26),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1988, 02, 17),
    end: DateTime(1989, 02, 05),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1987, 01, 29),
    end: DateTime(1988, 02, 16),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1986, 02, 09),
    end: DateTime(1987, 01, 28),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1985, 02, 20),
    end: DateTime(1986, 02, 08),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1984, 02, 02),
    end: DateTime(1985, 02, 19),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1983, 02, 13),
    end: DateTime(1984, 02, 01),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1982, 01, 25),
    end: DateTime(1983, 02, 12),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1981, 02, 05),
    end: DateTime(1982, 01, 24),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1980, 02, 16),
    end: DateTime(1981, 02, 04),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1979, 01, 28),
    end: DateTime(1980, 02, 15),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1978, 02, 07),
    end: DateTime(1979, 01, 27),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1977, 02, 18),
    end: DateTime(1978, 02, 06),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1976, 01, 31),
    end: DateTime(1977, 02, 17),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1975, 02, 11),
    end: DateTime(1976, 01, 30),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1974, 01, 23),
    end: DateTime(1975, 02, 10),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1973, 02, 03),
    end: DateTime(1974, 01, 22),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1972, 01, 16),
    end: DateTime(1973, 02, 02),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1971, 01, 27),
    end: DateTime(1972, 01, 15),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1970, 02, 06),
    end: DateTime(1971, 01, 26),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1969, 02, 17),
    end: DateTime(1970, 02, 05),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1968, 01, 30),
    end: DateTime(1969, 02, 16),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1967, 02, 09),
    end: DateTime(1968, 01, 29),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1966, 01, 21),
    end: DateTime(1967, 02, 08),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1965, 02, 02),
    end: DateTime(1966, 01, 20),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1964, 02, 13),
    end: DateTime(1965, 02, 01),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1963, 01, 25),
    end: DateTime(1964, 02, 12),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1962, 02, 05),
    end: DateTime(1963, 01, 24),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1961, 02, 15),
    end: DateTime(1962, 02, 04),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1960, 01, 28),
    end: DateTime(1961, 02, 14),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1959, 02, 08),
    end: DateTime(1960, 01, 27),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1958, 02, 18),
    end: DateTime(1959, 02, 07),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1957, 01, 31),
    end: DateTime(1958, 02, 17),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1956, 02, 12),
    end: DateTime(1957, 01, 30),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1955, 01, 24),
    end: DateTime(1956, 02, 11),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1954, 02, 03),
    end: DateTime(1955, 01, 23),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1953, 02, 14),
    end: DateTime(1954, 02, 02),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1952, 01, 27),
    end: DateTime(1953, 02, 13),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1951, 02, 06),
    end: DateTime(1952, 01, 26),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1950, 02, 17),
    end: DateTime(1951, 02, 05),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1949, 01, 29),
    end: DateTime(1950, 02, 16),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1948, 02, 10),
    end: DateTime(1949, 01, 28),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1947, 01, 22),
    end: DateTime(1948, 02, 09),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1946, 02, 02),
    end: DateTime(1947, 01, 21),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1945, 02, 13),
    end: DateTime(1946, 02, 01),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1944, 01, 25),
    end: DateTime(1945, 02, 12),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1943, 02, 05),
    end: DateTime(1944, 01, 24),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1942, 02, 15),
    end: DateTime(1943, 02, 04),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1941, 01, 27),
    end: DateTime(1942, 02, 14),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1940, 02, 08),
    end: DateTime(1941, 01, 26),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1939, 02, 19),
    end: DateTime(1940, 02, 07),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1938, 01, 31),
    end: DateTime(1939, 02, 18),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1937, 02, 11),
    end: DateTime(1938, 01, 30),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1936, 01, 24),
    end: DateTime(1937, 02, 10),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1935, 02, 04),
    end: DateTime(1936, 01, 23),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1934, 02, 14),
    end: DateTime(1935, 02, 03),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1933, 01, 26),
    end: DateTime(1934, 02, 13),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1932, 02, 06),
    end: DateTime(1933, 01, 25),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1931, 02, 17),
    end: DateTime(1932, 02, 05),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1930, 01, 30),
    end: DateTime(1931, 02, 16),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1929, 02, 10),
    end: DateTime(1930, 01, 29),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1928, 01, 23),
    end: DateTime(1929, 02, 09),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1927, 02, 02),
    end: DateTime(1928, 01, 22),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1926, 02, 13),
    end: DateTime(1927, 02, 01),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1925, 01, 25),
    end: DateTime(1926, 02, 12),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1924, 02, 05),
    end: DateTime(1925, 01, 24),
    zodiac: Zodiac.rat,
  ),
  ZodiacData(
    start: DateTime(1923, 02, 16),
    end: DateTime(1924, 02, 04),
    zodiac: Zodiac.boar,
  ),
  ZodiacData(
    start: DateTime(1922, 01, 28),
    end: DateTime(1923, 02, 15),
    zodiac: Zodiac.dog,
  ),
  ZodiacData(
    start: DateTime(1921, 02, 08),
    end: DateTime(1922, 01, 27),
    zodiac: Zodiac.rooster,
  ),
  ZodiacData(
    start: DateTime(1920, 02, 20),
    end: DateTime(1921, 02, 07),
    zodiac: Zodiac.monkey,
  ),
  ZodiacData(
    start: DateTime(1919, 02, 01),
    end: DateTime(1920, 02, 19),
    zodiac: Zodiac.goat,
  ),
  ZodiacData(
    start: DateTime(1918, 02, 11),
    end: DateTime(1919, 01, 31),
    zodiac: Zodiac.horse,
  ),
  ZodiacData(
    start: DateTime(1917, 01, 23),
    end: DateTime(1918, 02, 10),
    zodiac: Zodiac.snake,
  ),
  ZodiacData(
    start: DateTime(1916, 02, 03),
    end: DateTime(1917, 01, 22),
    zodiac: Zodiac.dragon,
  ),
  ZodiacData(
    start: DateTime(1915, 02, 14),
    end: DateTime(1916, 02, 02),
    zodiac: Zodiac.rabbit,
  ),
  ZodiacData(
    start: DateTime(1914, 01, 26),
    end: DateTime(1915, 02, 13),
    zodiac: Zodiac.tiger,
  ),
  ZodiacData(
    start: DateTime(1913, 02, 06),
    end: DateTime(1914, 01, 25),
    zodiac: Zodiac.ox,
  ),
  ZodiacData(
    start: DateTime(1912, 02, 18),
    end: DateTime(1913, 02, 05),
    zodiac: Zodiac.rat,
  ),
];
