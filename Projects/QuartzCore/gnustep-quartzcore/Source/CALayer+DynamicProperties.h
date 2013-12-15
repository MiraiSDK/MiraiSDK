/* CALayer+DynamicProperties.m

   Copyright (C) 2012 Free Software Foundation, Inc.
   
   Author: Ivan Vučica <ivan@vucica.net>
   Date: August 2012

   This file is part of QuartzCore.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; see the file COPYING.LIB.
   If not, see <http://www.gnu.org/licenses/> or write to the
   Free Software Foundation, 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.
*/

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface CALayer (DynamicProperties)
+ (void)_dynamicallyCreateProperty:(objc_property_t)property;

+ (NSDictionary *) _dynamicPropertyProcessAttributes: (objc_property_t)property;
+ (IMP) _getterForKey: (NSString *)key type: (NSString *)type;
+ (IMP) _setterForKey: (NSString *)key type: (NSString *)type;
@end
